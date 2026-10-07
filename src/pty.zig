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

pub extern "c" fn cfmakeraw(termios_p: *std.c.termios) void;

pub const PtySession = struct {
    master_fd: c_int,
    child_pid: std.c.pid_t,
    orig_termios: ?std.c.termios = null,
    is_raw: bool = false,

    pub fn spawn(sandbox_dir: []const u8, opt_cmd: ?[]const u8) !PtySession {
        var master: c_int = -1;
        var slave: c_int = -1;

        if (openpty(&master, &slave, null, null, null) != 0) {
            return error.OpenPtyFailed;
        }

        const pid = std.c.fork();
        if (pid < 0) {
            return error.ForkFailed;
        }

        if (pid == 0) {
            // Child process
            _ = std.c.close(master);

            // Create new session & establish controlling terminal
            _ = std.c.setsid();
            _ = std.c.ioctl(slave, 0x20007461, @as(c_int, 0));

            // Redirect stdin/stdout/stderr to slave PTY
            _ = std.c.dup2(slave, 0);
            _ = std.c.dup2(slave, 1);
            _ = std.c.dup2(slave, 2);
            _ = std.c.close(slave);

            // Change working directory to sandbox
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
                // Execute specific command in subshell
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
                    "CLITUTOR_SANDBOX=1",
                    null,
                };
                _ = std.c.execve(shell, &argv, &envp);
            } else {
                // Interactive shell
                const argv = [_:null]?[*:0]const u8{
                    shell,
                    "-i",
                    null,
                };
                const envp = [_:null]?[*:0]const u8{
                    "TERM=xterm-256color",
                    "CLITUTOR_SANDBOX=1",
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

    pub fn deinit(self: *PtySession) void {
        self.disableRawMode();
        _ = std.c.close(self.master_fd);
        _ = std.c.waitpid(self.child_pid, null, 0);
    }
};
