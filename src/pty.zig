const std = @import("std");
const builtin = @import("builtin");

// PTY libc bindings
pub extern "c" fn openpty(
    amaster: *c_int,
    aslave: *c_int,
    name: ?[*]u8,
    termp: ?*const anyopaque,
    winp: ?*const anyopaque,
) c_int;

pub extern "c" fn login_tty(fd: c_int) c_int;
pub extern "c" fn cfmakeraw(termios_p: *std.c.termios) void;

pub const winsize = extern struct {
    ws_row: u16 = 24,
    ws_col: u16 = 80,
    ws_xpixel: u16 = 0,
    ws_ypixel: u16 = 0,
};

pub const PtySession = struct {
    master_fd: c_int,
    child_pid: std.c.pid_t,
    orig_termios: ?std.c.termios = null,
    is_raw: bool = false,

    pub fn spawn(sandbox_dir: []const u8, opt_cmd: ?[]const u8) !PtySession {
        var master: c_int = -1;
        var slave: c_int = -1;

        var ws: winsize = .{};
        const has_ws = (std.c.ioctl(0, 0x40087468, @as(?*anyopaque, @ptrCast(&ws))) == 0);
        const winp: ?*const anyopaque = if (has_ws) @ptrCast(&ws) else null;

        if (openpty(&master, &slave, null, null, winp) != 0) {
            return error.OpenPtyFailed;
        }

        const pid = std.c.fork();
        if (pid < 0) {
            _ = std.c.close(master);
            _ = std.c.close(slave);
            return error.ForkFailed;
        }

        if (pid == 0) {
            // Child process
            _ = std.c.close(master);

            // Establish controlling session and redirect stdio cleanly
            if (login_tty(slave) != 0) {
                std.c.exit(1);
            }

            // Change working directory to isolated sandbox
            var dir_z: [1024:0]u8 = undefined;
            if (sandbox_dir.len < dir_z.len) {
                @memcpy(dir_z[0..sandbox_dir.len], sandbox_dir);
                dir_z[sandbox_dir.len] = 0;
                _ = std.c.chdir(&dir_z);
            }

            // Determine shell
            const shell_env = std.c.getenv("SHELL");
            const shell: [*:0]const u8 = shell_env orelse "/bin/sh";

            if (opt_cmd) |cmd| {
                var cmd_z: [2048:0]u8 = undefined;
                const copy_len = @min(cmd.len, cmd_z.len - 1);
                @memcpy(cmd_z[0..copy_len], cmd[0..copy_len]);
                cmd_z[copy_len] = 0;

                const argv = [_:null]?[*:0]const u8{
                    shell,
                    "-c",
                    &cmd_z,
                    null,
                };
                const envp = [_:null]?[*:0]const u8{
                    "TERM=xterm-256color",
                    "CLIT_SANDBOX=1",
                    null,
                };
                _ = std.c.execve(shell, &argv, &envp);
            } else {
                const argv = [_:null]?[*:0]const u8{
                    shell,
                    "-i",
                    null,
                };
                const envp = [_:null]?[*:0]const u8{
                    "TERM=xterm-256color",
                    "CLIT_SANDBOX=1",
                    null,
                };
                _ = std.c.execve(shell, &argv, &envp);
            }
            std.c.exit(127);
        }

        // Parent process: close slave side
        _ = std.c.close(slave);

        return PtySession{
            .master_fd = master,
            .child_pid = pid,
        };
    }

    pub fn enableRawMode(self: *PtySession) !void {
        if (std.c.isatty(0) == 0) return;
        var orig: std.c.termios = undefined;
        if (std.c.tcgetattr(0, &orig) != 0) return error.TcGetAttrFailed;
        self.orig_termios = orig;

        var raw = orig;
        cfmakeraw(&raw);

        if (std.c.tcsetattr(0, .NOW, &raw) != 0) return error.TcSetAttrFailed;
        self.is_raw = true;
    }

    pub fn disableRawMode(self: *PtySession) void {
        if (self.is_raw and self.orig_termios != null) {
            _ = std.c.tcsetattr(0, .NOW, &self.orig_termios.?);
            self.is_raw = false;
        }
    }

    /// Full duplex multiplexing loop using poll(2)
    pub fn runInteractive(self: *PtySession) !void {
        try self.enableRawMode();
        defer self.disableRawMode();

        var fds = [_]std.c.pollfd{
            .{ .fd = 0, .events = 0x0001, .revents = 0 }, // STDIN
            .{ .fd = self.master_fd, .events = 0x0001, .revents = 0 }, // PTY master
        };

        var buf: [4096]u8 = undefined;
        while (true) {
            // Poll with 100ms timeout to periodically check child process status
            const ret = std.c.poll(&fds, 2, 100);
            if (ret < 0) {
                const errno = std.c._errno().*;
                if (errno == 4) continue; // EINTR
                break;
            }

            // User keystroke from STDIN -> forward to PTY Master
            if (fds[0].fd >= 0 and (fds[0].revents & 0x0001) != 0) {
                const n = std.c.read(0, &buf, buf.len);
                if (n <= 0) {
                    // Stdin reached EOF (e.g. pipe finished). Send EOT to shell & stop polling STDIN
                    _ = std.c.write(self.master_fd, "\x04", 1);
                    fds[0].fd = -1;
                } else {
                    _ = std.c.write(self.master_fd, &buf, @as(usize, @intCast(n)));
                }
            } else if (fds[0].fd >= 0 and (fds[0].revents & (0x0010 | 0x0008)) != 0) {
                // Stdin hangup or error
                _ = std.c.write(self.master_fd, "\x04", 1);
                fds[0].fd = -1;
            }

            // Shell output from PTY Master -> forward to STDOUT
            if ((fds[1].revents & 0x0001) != 0) {
                const n = std.c.read(self.master_fd, &buf, buf.len);
                if (n <= 0) break;
                _ = std.c.write(1, &buf, @as(usize, @intCast(n)));
            }

            // Hangup / EOF / Error on master fd
            if ((fds[1].revents & (0x0010 | 0x0008 | 0x0020)) != 0 and (fds[1].revents & 0x0001) == 0) {
                break;
            }

            // Check if child process has exited
            var status: c_int = 0;
            const wait_res = std.c.waitpid(self.child_pid, &status, 1); // 1 = WNOHANG
            if (wait_res > 0) {
                // Flush any remaining output from master_fd
                while (true) {
                    const n = std.c.read(self.master_fd, &buf, buf.len);
                    if (n <= 0) break;
                    _ = std.c.write(1, &buf, @as(usize, @intCast(n)));
                }
                break;
            }
        }
    }

    pub fn deinit(self: *PtySession) void {
        self.disableRawMode();
        _ = std.c.close(self.master_fd);
        _ = std.c.kill(self.child_pid, .TERM); // SIGTERM
        _ = std.c.waitpid(self.child_pid, null, 0);
    }
};
