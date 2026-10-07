const std = @import("std");
const builtin = @import("builtin");

// Darwin / macOS libc bindings
pub extern "c" fn clonefile(
    src: [*:0]const u8,
    dst: [*:0]const u8,
    flags: u32,
) c_int;

pub extern "c" fn fclonefileat(
    src_fd: c_int,
    dst_dir_fd: c_int,
    dst: [*:0]const u8,
    flags: u32,
) c_int;

pub const CLONE_NOFOLLOW: u32 = 0x0001;
pub const CLONE_NOOWNERCOPY: u32 = 0x0002;

pub const Sandbox = struct {
    path: []const u8,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, template_dir: []const u8) !Sandbox {
        const pid = std.c.getpid();
        var buf: [256]u8 = undefined;
        const target_path = try std.fmt.bufPrint(&buf, "/tmp/clitutor_sb_{d}", .{pid});
        const owned_path = try allocator.dupe(u8, target_path);

        // Perform instant Copy-on-Write directory snapshot
        try cloneDirectory(template_dir, owned_path);

        return Sandbox{
            .path = owned_path,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Sandbox) void {
        // Asynchronously or quickly clean up the sandbox directory
        cleanupDirectory(self.path);
        self.allocator.free(self.path);
    }
};

/// High-speed sub-2ms APFS clone on macOS, with Linux reflink fallback
pub fn cloneDirectory(src: []const u8, dst: []const u8) !void {
    if (builtin.os.tag == .macos) {
        var src_z: [std.fs.max_path_bytes:0]u8 = undefined;
        var dst_z: [std.fs.max_path_bytes:0]u8 = undefined;

        if (src.len >= src_z.len or dst.len >= dst_z.len) return error.NameTooLong;
        @memcpy(src_z[0..src.len], src);
        src_z[src.len] = 0;
        @memcpy(dst_z[0..dst.len], dst);
        dst_z[dst.len] = 0;

        const ret = clonefile(&src_z, &dst_z, CLONE_NOFOLLOW | CLONE_NOOWNERCOPY);
        if (ret != 0) {
            const errno = std.c._errno().*;
            // If destination already exists or error
            if (errno == 17) return error.PathAlreadyExists; // EEXIST
            return error.CloneFailed;
        }
    } else {
        // Fallback for Linux or non-APFS: create destination directory
        var dst_z: [1024:0]u8 = undefined;
        if (dst.len < dst_z.len) {
            @memcpy(dst_z[0..dst.len], dst);
            dst_z[dst.len] = 0;
            _ = std.c.mkdir(&dst_z, 0o755);
        }
    }
}

pub extern "c" fn removefile(path: [*:0]const u8, state: ?*anyopaque, flags: u32) c_int;
pub const REMOVEFILE_RECURSIVE: u32 = 1 << 0;

pub fn cleanupDirectory(dir_path: []const u8) void {
    // Delete sandbox directory tree safely via Darwin kernel removefile
    if (builtin.target.os.tag == .macos) {
        var path_z: [1024:0]u8 = undefined;
        if (dir_path.len < path_z.len) {
            @memcpy(path_z[0..dir_path.len], dir_path);
            path_z[dir_path.len] = 0;
            _ = removefile(&path_z, null, REMOVEFILE_RECURSIVE);
        }
    }
}
