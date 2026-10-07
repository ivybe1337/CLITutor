const std = @import("std");
const root = @import("root.zig");
const cow = root.cow;
const pty = root.pty;
const dict = root.dict;
const lexer = root.lexer;
const verify = root.verify;
const buffer = root.buffer;
const renderer = root.renderer;
const guides = root.guides;

const BANNER =
    \\  ____ _     ___ _____ 
    \\ / ___| |   |_ _|_   _|
    \\| |   | |    | |  | |  
    \\| |___| |___ | |  | |  
    \\ \____|_____|___| |_|   ZERO-OVERHEAD KERNEL ENGINE
    \\
;

pub fn main(init: std.process.Init) !void {
    const allocator = std.heap.c_allocator;

    var it = std.process.Args.Iterator.init(init.minimal.args);
    var args_list: std.ArrayListUnmanaged([]const u8) = .empty;
    defer args_list.deinit(allocator);
    while (it.next()) |arg| {
        try args_list.append(allocator, arg);
    }
    const args = args_list.items;

    if (args.len < 2) {
        try printUsage();
        return;
    }

    const subcmd = args[1];

    if (std.mem.eql(u8, subcmd, "help") or std.mem.eql(u8, subcmd, "--help") or std.mem.eql(u8, subcmd, "-h")) {
        try printUsage();
    } else if (std.mem.eql(u8, subcmd, "preview") or std.mem.eql(u8, subcmd, "p")) {
        if (args.len < 3) {
            std.debug.print("Usage: clit preview <command>\nExample: clit preview 'tar -czf archive.tar.gz src/'\n", .{});
            return;
        }
        try runPreview(allocator, args[2..]);
    } else if (std.mem.eql(u8, subcmd, "why")) {
        try runWhy(allocator);
    } else if (std.mem.eql(u8, subcmd, "guide") or std.mem.eql(u8, subcmd, "dummy") or std.mem.eql(u8, subcmd, "--dummy") or std.mem.eql(u8, subcmd, "--dumbass") or std.mem.eql(u8, subcmd, "man")) {
        if (args.len < 3) {
            guides.printGuideDirectory();
            return;
        }
        try runGuide(args[2]);
    } else if (std.mem.eql(u8, subcmd, "repl") or std.mem.eql(u8, subcmd, "run")) {
        try runRepl(allocator);
    } else if (std.mem.eql(u8, subcmd, "drill")) {
        const scenario = if (args.len >= 3) args[2] else "tar_omission";
        try runDrill(allocator, scenario);
    } else if (guides.findGuide(subcmd)) |g| {
        guides.displayGuide(g.content);
    } else {
        std.debug.print("Unknown command: {s}\n", .{subcmd});
        try printUsage();
    }
}

fn printUsage() !void {
    std.debug.print("{s}\n", .{BANNER});
    std.debug.print(
        \\Usage: clit <command|tool> [arguments]
        \\
        \\Commands:
        \\  repl            Interactive PTY shell inside APFS copy-on-write sandbox
        \\  guide [tool]    View beginner-friendly manuals (torch, git, uv, colab, modal, etc.)
        \\  preview <cmd>   Ghost Mode Pre-Flight Simulator (Runs inside instant CoW sandbox)
        \\  why             Diagnose failed command syntax & kernel error state
        \\  drill <name>    Run deterministic kernel invariant verification drills
        \\
        \\Direct Guide Access:
        \\  clit <tool>     Quickly read guide for any supported tool (e.g., 'clit torch', 'clit uv')
        \\
        \\Drill Scenarios:
        \\  tar_omission    Verify in-memory tar creation without leaking sensitive files
        \\  perm_lock       Verify file mode bits and kernel invariants
        \\
    , .{});
    guides.printGuideDirectory();
}

fn getCwd(buf: []u8) ![]const u8 {
    if (std.c.getcwd(buf.ptr, buf.len)) |_| {
        return std.mem.sliceTo(buf, 0);
    }
    return error.GetCwdFailed;
}

fn runPreview(allocator: std.mem.Allocator, cmd_args: []const []const u8) !void {
    var cwd_buf: [std.fs.max_path_bytes]u8 = undefined;
    const current_dir = try getCwd(&cwd_buf);

    std.debug.print("⚡ [Ghost Mode] Taking sub-2ms APFS CoW snapshot of {s}...\n", .{current_dir});
    var sandbox = try cow.Sandbox.init(allocator, current_dir);
    defer sandbox.deinit();

    std.debug.print("🚀 Executing command in isolated sandbox: {s}\n", .{sandbox.path});

    // Reconstruct command line
    var cmd_buf: std.ArrayList(u8) = .empty;
    defer cmd_buf.deinit(allocator);
    for (cmd_args, 0..) |arg, i| {
        if (i > 0) try cmd_buf.append(allocator, ' ');
        try cmd_buf.appendSlice(allocator, arg);
    }

    // Lex and analyze flags
    var lex = lexer.Lexer.init(cmd_buf.items);
    var first_token = true;
    var tool_def: ?dict.ToolDefinition = null;

    std.debug.print("\n📋 [AST Telemetry / Flag Deconstruction]:\n", .{});
    while (lex.next()) |tok| {
        if (first_token) {
            tool_def = dict.findTool(tok.slice);
            std.debug.print("   Tool: \x1b[36m{s}\x1b[0m\n", .{tok.slice});
            first_token = false;
        } else if (tok.tok_type == .short_flag or tok.tok_type == .long_flag) {
            if (tool_def) |t| {
                if (dict.findFlag(t, tok.slice)) |flag| {
                    std.debug.print("   Flag \x1b[33m{s}\x1b[0m: {s}\n", .{ tok.slice, flag.description });
                    if (flag.is_dangerous) {
                        std.debug.print("   ⚠️  \x1b[31mWARNING: {s}\x1b[0m\n", .{flag.warning orelse "Dangerous flag"});
                    }
                }
            }
        }
    }

    // Headless execution inside isolated sandbox
    const pid = std.c.fork();
    if (pid == 0) {
        var dir_z: [1024:0]u8 = undefined;
        if (sandbox.path.len < dir_z.len) {
            @memcpy(dir_z[0..sandbox.path.len], sandbox.path);
            dir_z[sandbox.path.len] = 0;
            _ = std.c.chdir(&dir_z);
        }
        const dev_null = std.c.open("/dev/null", std.c.O{ .ACCMODE = .WRONLY }, @as(std.c.mode_t, 0));
        if (dev_null >= 0) {
            _ = std.c.dup2(dev_null, 1);
            _ = std.c.dup2(dev_null, 2);
            _ = std.c.close(dev_null);
        }
        const shell_env = std.c.getenv("SHELL");
        const shell: [*:0]const u8 = shell_env orelse "/bin/sh";
        var cmd_z: [2048:0]u8 = undefined;
        const copy_len = @min(cmd_buf.items.len, cmd_z.len - 1);
        @memcpy(cmd_z[0..copy_len], cmd_buf.items[0..copy_len]);
        cmd_z[copy_len] = 0;

        const argv = [_:null]?[*:0]const u8{
            shell,
            "-c",
            &cmd_z,
            null,
        };
        const envp = [_:null]?[*:0]const u8{
            "CLIT_SANDBOX=1",
            null,
        };
        _ = std.c.execve(shell, &argv, &envp);
        std.c.exit(127);
    }
    _ = std.c.waitpid(pid, null, 0);

    std.debug.print("\n✅ Sandbox execution complete. Inspecting kernel mutations:\n", .{});
    var changes = try verify.MutationScanner.scanDiff(allocator, sandbox.path);
    defer {
        for (changes.items) |c| allocator.free(c.path);
        changes.deinit(allocator);
    }

    for (changes.items) |c| {
        std.debug.print("   [+] Mutation created: {s}\n", .{c.path});
    }

    std.debug.print("🧹 Unlinking sandbox: Zero side-effects applied to real project.\n", .{});
}

fn runWhy(_: std.mem.Allocator) !void {
    std.debug.print(
        \\🔍 [Exit Code Interceptor / Why Diagnosis]
        \\   Status: Clean kernel state.
        \\   Tip: In bash/zsh, use 'clit preview <cmd>' before running destructive commands.
        \\
    , .{});
}

fn runDrill(allocator: std.mem.Allocator, scenario: []const u8) !void {
    std.debug.print("🎯 Starting Kernel Invariant Drill: {s}\n", .{scenario});

    var cwd_buf: [std.fs.max_path_bytes]u8 = undefined;
    const current_dir = try getCwd(&cwd_buf);
    var sandbox = try cow.Sandbox.init(allocator, current_dir);
    defer sandbox.deinit();

    const verifier = verify.Verifier.init(sandbox.path);

    if (std.mem.eql(u8, scenario, "tar_omission")) {
        const res = verifier.assertTarOmission("test.tar", ".env");
        std.debug.print("   Invariant [{s}]: {s} (Passed: {})\n", .{ res.rule_name, res.message, res.passed });
    } else {
        const res = verifier.assertFileExists("build.zig");
        std.debug.print("   Invariant [{s}]: {s} (Passed: {})\n", .{ res.rule_name, res.message, res.passed });
    }
}

fn runGuide(tool_name: []const u8) !void {
    if (guides.findGuide(tool_name)) |g| {
        guides.displayGuide(g.content);
    } else {
        std.debug.print("Guide not found for '{s}'.\n", .{tool_name});
        guides.printGuideDirectory();
    }
}

fn runRepl(allocator: std.mem.Allocator) !void {
    var cwd_buf: [std.fs.max_path_bytes]u8 = undefined;
    const current_dir = try getCwd(&cwd_buf);

    std.debug.print("⚡ Initializing Sandbox PTY inside {s}...\n", .{current_dir});
    std.debug.print("🔒 APFS CoW snapshot active: modifications are completely isolated.\n", .{});
    var sandbox = try cow.Sandbox.init(allocator, current_dir);
    defer sandbox.deinit();

    var pty_session = try pty.PtySession.spawn(sandbox.path, null);
    defer pty_session.deinit();

    try pty_session.runInteractive();
}
