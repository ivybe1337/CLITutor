const std = @import("std");

pub const Guide = struct {
    name: []const u8,
    title: []const u8,
    aliases: []const []const u8,
    content: []const u8,
};

pub const ALL_GUIDES = [_]Guide{
    .{
        .name = "torch",
        .title = "PyTorch (Deep Learning & GPU Acceleration)",
        .aliases = &.{ "pytorch", "pt" },
        .content = @embedFile("guides_data/torch.md"),
    },
    .{
        .name = "uv",
        .title = "Astral uv (Fast Python Package & Environment Manager)",
        .aliases = &.{ "pip", "python", "py", "venv" },
        .content = @embedFile("guides_data/uv.md"),
    },
    .{
        .name = "llamacpp",
        .title = "llama.cpp (Local GGUF LLM Inference Engine)",
        .aliases = &.{ "llama", "gguf", "llama-cpp" },
        .content = @embedFile("guides_data/llamacpp.md"),
    },
    .{
        .name = "colab",
        .title = "Google Colab (Interactive Cloud Notebooks & GPUs)",
        .aliases = &.{ "googlecolab", "jupyter" },
        .content = @embedFile("guides_data/colab.md"),
    },
    .{
        .name = "modal",
        .title = "Modal Labs (Serverless Cloud GPU & Function Execution)",
        .aliases = &.{"modal-labs"},
        .content = @embedFile("guides_data/modal.md"),
    },
    .{
        .name = "kaggle",
        .title = "Kaggle (Competitions, Datasets & GPU Kernels)",
        .aliases = &.{},
        .content = @embedFile("guides_data/kaggle.md"),
    },
    .{
        .name = "git",
        .title = "Git & GitHub CLI (Source Control & Collaboration)",
        .aliases = &.{ "gh", "github" },
        .content = @embedFile("guides_data/git.md"),
    },
    .{
        .name = "aws",
        .title = "AWS CLI (Amazon Web Services Management)",
        .aliases = &.{ "amazon", "s3", "ec2" },
        .content = @embedFile("guides_data/aws.md"),
    },
    .{
        .name = "bun",
        .title = "Bun & TypeScript (Fast JS/TS Runtime & Package Manager)",
        .aliases = &.{ "typescript", "ts", "npm", "pnpm" },
        .content = @embedFile("guides_data/bun.md"),
    },
    .{
        .name = "brew",
        .title = "Homebrew (macOS / Linux Package Manager)",
        .aliases = &.{ "homebrew" },
        .content = @embedFile("guides_data/brew.md"),
    },
    .{
        .name = "zig",
        .title = "Zig (Robust Systems Programming & Toolchain)",
        .aliases = &.{ "ziglang" },
        .content = @embedFile("guides_data/zig.md"),
    },
    .{
        .name = "cargo",
        .title = "Rust & Cargo (Safe Systems Programming & Crates)",
        .aliases = &.{ "rust", "rs" },
        .content = @embedFile("guides_data/cargo.md"),
    },
    .{
        .name = "swift",
        .title = "Swift (Apple Platform & Server Systems)",
        .aliases = &.{ "swiftc" },
        .content = @embedFile("guides_data/swift.md"),
    },
    .{
        .name = "claude",
        .title = "Claude Code (Anthropic Agentic CLI Tooling)",
        .aliases = &.{ "anthropic" },
        .content = @embedFile("guides_data/claude.md"),
    },
    .{
        .name = "codex",
        .title = "OpenAI Codex / LLM CLI Interfaces",
        .aliases = &.{ "openai" },
        .content = @embedFile("guides_data/codex.md"),
    },
    .{
        .name = "gemini",
        .title = "Google Gemini CLI & API Ecosystem",
        .aliases = &.{ "google" },
        .content = @embedFile("guides_data/gemini.md"),
    },
};

pub fn findGuide(query: []const u8) ?Guide {
    for (ALL_GUIDES) |g| {
        if (std.mem.eql(u8, g.name, query)) return g;
        for (g.aliases) |alias| {
            if (std.mem.eql(u8, alias, query)) return g;
        }
    }
    return null;
}

pub extern "c" fn pipe(pipefd: *[2]c_int) c_int;
pub extern "c" fn execvp(file: [*:0]const u8, argv: [*:null]const ?[*:0]const u8) c_int;

pub fn displayGuide(content: []const u8) void {
    // If output is not a TTY (e.g. redirected or piped), output plain text directly
    if (std.c.isatty(1) == 0) {
        _ = std.c.write(1, content.ptr, content.len);
        return;
    }

    var pipefd: [2]c_int = undefined;
    if (pipe(&pipefd) != 0) {
        _ = std.c.write(1, content.ptr, content.len);
        return;
    }

    const pid = std.c.fork();
    if (pid < 0) {
        _ = std.c.close(pipefd[0]);
        _ = std.c.close(pipefd[1]);
        _ = std.c.write(1, content.ptr, content.len);
        return;
    }

    if (pid == 0) {
        // Child pager
        _ = std.c.close(pipefd[1]); // Close write end
        _ = std.c.dup2(pipefd[0], 0); // Pipe is child stdin
        _ = std.c.close(pipefd[0]);

        // Attempt bat first
        const bat_argv = [_:null]?[*:0]const u8{
            "bat",
            "--paging=always",
            "--style=plain",
            "-l",
            "md",
            null,
        };
        _ = execvp("bat", &bat_argv);

        // Fallback to less
        const less_argv = [_:null]?[*:0]const u8{
            "less",
            "-R",
            null,
        };
        _ = execvp("less", &less_argv);

        // Fallback to cat
        const cat_argv = [_:null]?[*:0]const u8{
            "cat",
            null,
        };
        _ = execvp("cat", &cat_argv);
        std.c.exit(1);
    }

    // Parent writer
    _ = std.c.close(pipefd[0]); // Close read end

    // Stream content to pager stdin
    var written: usize = 0;
    while (written < content.len) {
        const remaining = content[written..];
        const n = std.c.write(pipefd[1], remaining.ptr, remaining.len);
        if (n <= 0) break;
        written += @as(usize, @intCast(n));
    }
    _ = std.c.close(pipefd[1]); // Send EOF to pager

    // Wait for user to exit pager
    _ = std.c.waitpid(pid, null, 0);
}

pub fn printGuideDirectory() void {
    std.debug.print(
        \\
        \\📚 Available Guides in CLIT:
        \\   Use 'clit guide <tool>' to read any guide.
        \\
        \\
    , .{});

    for (ALL_GUIDES) |g| {
        std.debug.print("   • \x1b[36m{s:<10}\x1b[0m : {s}\n", .{ g.name, g.title });
    }
    std.debug.print("\n", .{});
}
