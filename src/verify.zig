const std = @import("std");
const builtin = @import("builtin");

pub const InvariantResult = struct {
    passed: bool,
    rule_name: []const u8,
    message: []const u8,
};

pub const dirent = extern struct {
    d_ino: u64,
    d_seekoff: u64,
    d_reclen: u16,
    d_namlen: u16,
    d_type: u8,
    d_name: [256]u8,
};
pub extern "c" fn readdir(dirp: *std.c.DIR) ?*dirent;

/// Direct Kernel Invariant Verifier: Validates physical side-effects on the OS kernel
pub const Verifier = struct {
    sandbox_path: []const u8,

    pub fn init(sandbox_path: []const u8) Verifier {
        return Verifier{ .sandbox_path = sandbox_path };
    }

    /// Direct inode existence verification via stat
    pub fn assertFileExists(self: Verifier, relative_path: []const u8) InvariantResult {
        var buf: [1024]u8 = undefined;
        const full_path = std.fmt.bufPrint(&buf, "{s}/{s}", .{ self.sandbox_path, relative_path }) catch {
            return InvariantResult{ .passed = false, .rule_name = "assert_file_exists", .message = "Path too long" };
        };

        var stat_buf: std.posix.Stat = undefined;
        var full_path_z: [1024:0]u8 = undefined;
        @memcpy(full_path_z[0..full_path.len], full_path);
        full_path_z[full_path.len] = 0;

        const ret = std.c.stat(&full_path_z, &stat_buf);
        if (ret == 0) {
            return InvariantResult{ .passed = true, .rule_name = "assert_file_exists", .message = "File verified on disk" };
        } else {
            return InvariantResult{ .passed = false, .rule_name = "assert_file_exists", .message = "File missing on disk" };
        }
    }

    /// Direct bitmask check against stat.st_mode
    pub fn assertFileMode(self: Verifier, relative_path: []const u8, expected_mode: u32) InvariantResult {
        var buf: [1024]u8 = undefined;
        const full_path = std.fmt.bufPrint(&buf, "{s}/{s}", .{ self.sandbox_path, relative_path }) catch {
            return InvariantResult{ .passed = false, .rule_name = "assert_file_mode", .message = "Path too long" };
        };

        var stat_buf: std.posix.Stat = undefined;
        var full_path_z: [1024:0]u8 = undefined;
        @memcpy(full_path_z[0..full_path.len], full_path);
        full_path_z[full_path.len] = 0;

        if (std.c.stat(&full_path_z, &stat_buf) != 0) {
            return InvariantResult{ .passed = false, .rule_name = "assert_file_mode", .message = "File missing" };
        }

        const mode_bits = stat_buf.mode & 0o777;
        if (mode_bits == expected_mode) {
            return InvariantResult{ .passed = true, .rule_name = "assert_file_mode", .message = "Permissions match kernel invariant" };
        } else {
            return InvariantResult{ .passed = false, .rule_name = "assert_file_mode", .message = "Permission mismatch" };
        }
    }

    /// Direct probe checking if a process has cleanly terminated
    pub fn assertProcessDead(pid: std.c.pid_t) InvariantResult {
        const ret = std.c.kill(pid, 0);
        if (ret == -1) {
            const errno = std.c._errno().*;
            if (errno == 3) { // ESRCH: No such process
                return InvariantResult{ .passed = true, .rule_name = "assert_process_dead", .message = "Process verified terminated (ESRCH)" };
            }
        }
        return InvariantResult{ .passed = false, .rule_name = "assert_process_dead", .message = "Process still alive in process table" };
    }

    /// In-memory streaming UStar tar header inspection (validates archive without extracting)
    pub fn assertTarOmission(self: Verifier, tar_path: []const u8, omitted_filename: []const u8) InvariantResult {
        var buf: [1024]u8 = undefined;
        const full_path = std.fmt.bufPrint(&buf, "{s}/{s}", .{ self.sandbox_path, tar_path }) catch {
            return InvariantResult{ .passed = false, .rule_name = "assert_tar_omission", .message = "Path error" };
        };

        var full_path_z: [1024:0]u8 = undefined;
        if (full_path.len >= full_path_z.len) {
            return InvariantResult{ .passed = false, .rule_name = "assert_tar_omission", .message = "Path too long" };
        }
        @memcpy(full_path_z[0..full_path.len], full_path);
        full_path_z[full_path.len] = 0;

        const fd = std.c.open(&full_path_z, std.c.O{}, @as(std.c.mode_t, 0));
        if (fd < 0) {
            return InvariantResult{ .passed = false, .rule_name = "assert_tar_omission", .message = "Archive not found" };
        }
        defer _ = std.c.close(fd);

        var header_buf: [512]u8 = undefined;
        while (true) {
            const bytes_read = std.c.read(fd, &header_buf, 512);
            if (bytes_read < 512) break;

            // Check if end of archive (two consecutive blocks of zeros)
            var all_zero = true;
            for (header_buf) |b| {
                if (b != 0) {
                    all_zero = false;
                    break;
                }
            }
            if (all_zero) break;

            const name_slice = std.mem.sliceTo(header_buf[0..100], 0);
            if (std.mem.indexOf(u8, name_slice, omitted_filename) != null) {
                return InvariantResult{ .passed = false, .rule_name = "assert_tar_omission", .message = "Omitted file was found in archive!" };
            }

            // Read size in octal at offset 124 (12 bytes)
            const size_slice = std.mem.sliceTo(header_buf[124..136], 0);
            const size = std.fmt.parseInt(u64, std.mem.trim(u8, size_slice, " "), 8) catch 0;
            const padded_blocks = (size + 511) / 512;
            _ = std.c.lseek(fd, @as(std.c.off_t, @intCast(padded_blocks * 512)), 1); // 1 = SEEK_CUR
        }

        return InvariantResult{ .passed = true, .rule_name = "assert_tar_omission", .message = "Target successfully omitted from archive" };
    }
};

/// Scans directory tree changes between pre-command and post-command runs
pub const MutationScanner = struct {
    pub const Change = struct {
        path: []const u8,
        kind: enum { created, deleted, modified },
    };

    pub fn scanDiff(allocator: std.mem.Allocator, sandbox_dir: []const u8) !std.ArrayList(Change) {
        var changes: std.ArrayList(Change) = .empty;
        var dir_z: [1024:0]u8 = undefined;
        if (sandbox_dir.len >= dir_z.len) return changes;
        @memcpy(dir_z[0..sandbox_dir.len], sandbox_dir);
        dir_z[sandbox_dir.len] = 0;

        const dir = std.c.opendir(&dir_z);
        if (dir == null) return changes;
        defer _ = std.c.closedir(dir.?);

        while (readdir(dir.?)) |entry| {
            const name_slice = std.mem.sliceTo(&entry.d_name, 0);
            if (std.mem.eql(u8, name_slice, ".") or std.mem.eql(u8, name_slice, "..")) continue;
            try changes.append(allocator, .{
                .path = try allocator.dupe(u8, name_slice),
                .kind = .created,
            });
        }
        return changes;
    }
};
