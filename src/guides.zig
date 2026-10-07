const std = @import("std");

pub const Guide = struct {
    name: []const u8,
    title: []const u8,
    aliases: []const []const u8,
    content: []const u8,
};

pub const ALL_GUIDES = [_]Guide{
    // Deep Learning & Inference
    .{
        .name = "torch",
        .title = "PyTorch (Deep Learning & GPU Acceleration)",
        .aliases = &.{ "pytorch", "pt" },
        .content = @embedFile("guides_data/torch.md"),
    },
    .{
        .name = "llamacpp",
        .title = "llama.cpp (Local GGUF LLM Inference Engine)",
        .aliases = &.{ "llama", "gguf", "llama-cpp" },
        .content = @embedFile("guides_data/llamacpp.md"),
    },
    .{
        .name = "accelerate",
        .title = "HuggingFace Accelerate (Multi-GPU & Distributed PyTorch)",
        .aliases = &.{ "hf-accelerate" },
        .content = @embedFile("guides_data/accelerate.md"),
    },
    .{
        .name = "transformers",
        .title = "Hugging Face Transformers (Pretrained Models & Pipelines)",
        .aliases = &.{ "huggingface", "hf" },
        .content = @embedFile("guides_data/transformers.md"),
    },
    .{
        .name = "ollama",
        .title = "Ollama (Local LLM Serving & Modelfiles)",
        .aliases = &.{ "oll" },
        .content = @embedFile("guides_data/ollama.md"),
    },
    .{
        .name = "vllm",
        .title = "vLLM (High-Throughput PagedAttention LLM Serving)",
        .aliases = &.{ "v-llm" },
        .content = @embedFile("guides_data/vllm.md"),
    },
    .{
        .name = "triton",
        .title = "OpenAI Triton (Python GPU Kernel Programming)",
        .aliases = &.{ "triton-gpu", "openai-triton" },
        .content = @embedFile("guides_data/triton.md"),
    },

    // Cloud, Serverless & Infrastructure
    .{
        .name = "modal",
        .title = "Modal Labs (Serverless Cloud GPU & Function Execution)",
        .aliases = &.{"modal-labs"},
        .content = @embedFile("guides_data/modal.md"),
    },
    .{
        .name = "colab",
        .title = "Google Colab (Interactive Cloud Notebooks & GPUs)",
        .aliases = &.{ "googlecolab", "jupyter" },
        .content = @embedFile("guides_data/colab.md"),
    },
    .{
        .name = "kaggle",
        .title = "Kaggle (Competitions, Datasets & GPU Kernels)",
        .aliases = &.{},
        .content = @embedFile("guides_data/kaggle.md"),
    },
    .{
        .name = "aws",
        .title = "AWS CLI (Amazon Web Services Management)",
        .aliases = &.{ "amazon", "s3", "ec2" },
        .content = @embedFile("guides_data/aws.md"),
    },
    .{
        .name = "gcp",
        .title = "Google Cloud SDK (gcloud, Cloud Storage & Compute)",
        .aliases = &.{ "gcloud", "googlecloud" },
        .content = @embedFile("guides_data/gcp.md"),
    },
    .{
        .name = "vercel",
        .title = "Vercel CLI (Deployments, Previews & Env Management)",
        .aliases = &.{ "vc" },
        .content = @embedFile("guides_data/vercel.md"),
    },
    .{
        .name = "docker",
        .title = "Docker (Containers, Volumes, Compose & Images)",
        .aliases = &.{ "compose", "docker-compose" },
        .content = @embedFile("guides_data/docker.md"),
    },
    .{
        .name = "kubectl",
        .title = "Kubernetes (kubectl, Pods, Services & Deployments)",
        .aliases = &.{ "k8s", "kube", "kubernetes" },
        .content = @embedFile("guides_data/kubectl.md"),
    },
    .{
        .name = "terraform",
        .title = "Terraform (Infrastructure as Code & State Management)",
        .aliases = &.{ "tf", "iac" },
        .content = @embedFile("guides_data/terraform.md"),
    },

    // Toolchains, Languages & Runtimes
    .{
        .name = "uv",
        .title = "Astral uv (Fast Python Package & Environment Manager)",
        .aliases = &.{ "pip", "python", "py", "venv" },
        .content = @embedFile("guides_data/uv.md"),
    },
    .{
        .name = "bun",
        .title = "Bun & TypeScript (Fast JS/TS Runtime & Package Manager)",
        .aliases = &.{ "typescript", "ts" },
        .content = @embedFile("guides_data/bun.md"),
    },
    .{
        .name = "pnpm",
        .title = "pnpm (Disk-Efficient Fast Node.js Package Manager)",
        .aliases = &.{ "pn", "npm" },
        .content = @embedFile("guides_data/pnpm.md"),
    },
    .{
        .name = "deno",
        .title = "Deno (Secure TypeScript/JavaScript Runtime)",
        .aliases = &.{ "denoland" },
        .content = @embedFile("guides_data/deno.md"),
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

    // Databases & Analytical Engines
    .{
        .name = "duckdb",
        .title = "DuckDB (In-Process Analytical SQL & Parquet Querying)",
        .aliases = &.{ "duck", "parquet-sql" },
        .content = @embedFile("guides_data/duckdb.md"),
    },
    .{
        .name = "sqlite3",
        .title = "SQLite (Zero-Config Embedded Database & Dot-Commands)",
        .aliases = &.{ "sqlite", "sql" },
        .content = @embedFile("guides_data/sqlite3.md"),
    },
    .{
        .name = "postgres",
        .title = "PostgreSQL (psql, Explain Analyze & Schema Introspection)",
        .aliases = &.{ "psql", "pg", "postgresql" },
        .content = @embedFile("guides_data/postgres.md"),
    },
    .{
        .name = "redis",
        .title = "Redis (In-Memory Key-Value Caching & Queues)",
        .aliases = &.{ "redis-cli", "valkey" },
        .content = @embedFile("guides_data/redis.md"),
    },

    // Terminal Superpowers & CLI Utilities
    .{
        .name = "tmux",
        .title = "tmux (Terminal Multiplexer, Background Sessions & Panes)",
        .aliases = &.{ "multiplexer" },
        .content = @embedFile("guides_data/tmux.md"),
    },
    .{
        .name = "fzf",
        .title = "fzf (Command-Line Interactive Fuzzy Finder)",
        .aliases = &.{ "fuzzy" },
        .content = @embedFile("guides_data/fzf.md"),
    },
    .{
        .name = "jq",
        .title = "jq (Lightweight Command-Line JSON Processor)",
        .aliases = &.{ "json-processor" },
        .content = @embedFile("guides_data/jq.md"),
    },
    .{
        .name = "rg",
        .title = "ripgrep (Ultra-Fast Regex Code Search)",
        .aliases = &.{ "ripgrep", "grep" },
        .content = @embedFile("guides_data/rg.md"),
    },
    .{
        .name = "eza",
        .title = "eza (Modern ls Replacement with Git Status & Tree)",
        .aliases = &.{ "ls", "exa" },
        .content = @embedFile("guides_data/eza.md"),
    },
    .{
        .name = "bat",
        .title = "bat (Modern cat with Syntax Highlighting & Paging)",
        .aliases = &.{ "cat", "batcat" },
        .content = @embedFile("guides_data/bat.md"),
    },
    .{
        .name = "zoxide",
        .title = "zoxide (Smarter Frecency-Based cd Command)",
        .aliases = &.{ "z", "cd" },
        .content = @embedFile("guides_data/zoxide.md"),
    },
    .{
        .name = "ffmpeg",
        .title = "FFmpeg (Audio & Video Transcoding, Compression & Streams)",
        .aliases = &.{ "ffprobe", "video" },
        .content = @embedFile("guides_data/ffmpeg.md"),
    },
    .{
        .name = "curl",
        .title = "curl (Network Data Transfers, HTTP API Requests & Auth)",
        .aliases = &.{ "http", "fetch" },
        .content = @embedFile("guides_data/curl.md"),
    },
    .{
        .name = "rsync",
        .title = "rsync (Fast Delta-Transfer File & Remote Directory Sync)",
        .aliases = &.{ "sync" },
        .content = @embedFile("guides_data/rsync.md"),
    },
    .{
        .name = "ssh",
        .title = "SSH (Secure Shell, Keypairs, Config Aliases & Tunnels)",
        .aliases = &.{ "ssh-keygen", "scp" },
        .content = @embedFile("guides_data/ssh.md"),
    },
    .{
        .name = "tar",
        .title = "tar (Tape Archive, Gzip Compression & POSIX Bundles)",
        .aliases = &.{ "untar", "gzip" },
        .content = @embedFile("guides_data/tar.md"),
    },
    .{
        .name = "lsof",
        .title = "lsof (List Open Files, Locked Ports & Sockets)",
        .aliases = &.{ "ports", "netstat" },
        .content = @embedFile("guides_data/lsof.md"),
    },
    .{
        .name = "nmap",
        .title = "Nmap (Network Exploration, Port Scanning & Auditing)",
        .aliases = &.{ "scan", "portscan" },
        .content = @embedFile("guides_data/nmap.md"),
    },

    // Python Quality & Testing
    .{
        .name = "ruff",
        .title = "Ruff (Ultra-Fast Rust-Powered Python Linter & Formatter)",
        .aliases = &.{ "linter", "black", "flake8" },
        .content = @embedFile("guides_data/ruff.md"),
    },
    .{
        .name = "pytest",
        .title = "pytest (Python Testing Framework & Fixtures)",
        .aliases = &.{ "test", "py-test" },
        .content = @embedFile("guides_data/pytest.md"),
    },
    .{
        .name = "mypy",
        .title = "mypy (Optional Static Type Checker for Python)",
        .aliases = &.{ "types", "typecheck" },
        .content = @embedFile("guides_data/mypy.md"),
    },
    .{
        .name = "fastapi",
        .title = "FastAPI (High-Performance Modern Python Web APIs)",
        .aliases = &.{ "uvicorn" },
        .content = @embedFile("guides_data/fastapi.md"),
    },

    // Agentic AI & Collaboration
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
    .{
        .name = "aider",
        .title = "Aider (Terminal AI Pair Programmer with Git Commits)",
        .aliases = &.{ "ai-coder" },
        .content = @embedFile("guides_data/aider.md"),
    },
    .{
        .name = "git",
        .title = "Git & GitHub CLI (Source Control & Collaboration)",
        .aliases = &.{ "gh", "github" },
        .content = @embedFile("guides_data/git.md"),
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
        \\📚 Available Guides in CLIT (51 Guides):
        \\   Use 'clit guide <tool>' or 'clit <tool>' to read any guide.
        \\
        \\
    , .{});

    for (ALL_GUIDES) |g| {
        std.debug.print("   • \x1b[36m{s:<14}\x1b[0m : {s}\n", .{ g.name, g.title });
    }
    std.debug.print("\n", .{});
}
