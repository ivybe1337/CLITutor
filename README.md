# `clit` — CLI / REPL Zero-Overhead Kernel Engine & Noob Manuals

```
  ____ _     ___ _____ 
 / ___| |   |_ _|_   _|
| |   | |    | |  | |  
| |___| |___ | |  | |  
 \____|_____|___| |_|   ZERO-OVERHEAD KERNEL ENGINE
```

`clit` is a blazingly fast, zero-overhead developer terminal engine and interactive manual toolchain written in **Zig 0.17.0**.

It delivers:
1. **Interactive APFS / Reflink CoW Sandbox REPL**: Experiment with arbitrary commands in an isolated subshell with copy-on-write filesystem guarantees and sub-2ms startup.
2. **Ghost Mode Pre-Flight Simulator (`clit preview <cmd>`)**: Dry-run destructive commands inside an APFS CoW sandbox, analyze AST flags, and review real kernel filesystem mutations before running on real projects.
3. **Embedded Noob-Friendly Manuals (`clit <tool>` or `clit guide <tool>`)**: 16 comprehensive, self-contained guides embedded directly into the binary's `.rodata` section (no disk lookups, sub-millisecond launch, works from any directory).
4. **Deterministic Kernel Invariant Verifier (`clit drill`)**: Inode, file mode, and in-memory tar header verification.

---

## 🚀 Quick Start

### Installation

Requires [Zig](https://ziglang.org/) `0.17.0`:

```bash
git clone https://github.com/ivybe1337/CLITutor.git
cd CLITutor
zig build -Drelease -p ~/.local
```

Ensure `~/.local/bin` is in your `$PATH`.

---

## 📖 Embedded Guides for Dummies

Run `clit <tool>` or `clit guide <tool>` from **any** directory to open the interactive manual in your preferred pager (`bat` / `less` / terminal):

| Command | Manual |
| :--- | :--- |
| `clit torch` | **PyTorch** (Deep Learning, CUDA vs MPS Apple Silicon, Tensors) |
| `clit uv` | **Astral uv** (Fast Python, project sync, venvs, `uv tool`, `uv run`) |
| `clit llamacpp` | **llama.cpp** (Local GGUF models, quantized LLM inference, flags) |
| `clit colab` | **Google Colab** (Interactive GPU notebooks, drive mounting, tips) |
| `clit modal` | **Modal Labs** (Serverless cloud GPUs, web endpoints, volumes) |
| `clit kaggle` | **Kaggle** (Datasets, GPU kernels, competition submissions) |
| `clit git` | **Git & GitHub CLI** (Source control, branches, PRs, `gh` integration) |
| `clit aws` | **AWS CLI** (S3, EC2, credentials, profiles, pagination) |
| `clit bun` | **Bun & TypeScript** (Fast runtime, package manager, ts-node replacement) |
| `clit brew` | **Homebrew** (Formulae, casks, services, cleanup) |
| `clit zig` | **Zig** (Build system, C interop, memory safety, cross-compilation) |
| `clit cargo` | **Rust & Cargo** (Crates, release flags, workspaces, clippy) |
| `clit swift` | **Swift** (Swift package manager, Apple platforms, CLI utilities) |
| `clit claude` | **Claude Code** (Anthropic Agentic CLI toolchain & commands) |
| `clit codex` | **OpenAI Codex / LLM CLI** (CLI interfaces and prompt runners) |
| `clit gemini` | **Google Gemini** (CLI and developer API ecosystem) |

To list all available guides:
```bash
clit guide
```

---

## ⚡ Features & Workflows

### 1. Interactive Sandbox REPL (`clit repl`)
Spawns an interactive shell inside a temporary copy-on-write sandbox. Any files created, modified, or deleted inside the sandbox vanish upon exit without affecting your host directory:

```bash
clit repl
```

### 2. Ghost Mode Simulator (`clit preview <cmd>`)
Simulates execution of any command inside an APFS copy-on-write clone, deconstructs flags with danger warnings, and prints the exact kernel filesystem mutations that would take place:

```bash
clit preview 'tar -czf archive.tar.gz src/'
clit preview 'touch test.txt && rm -rf old_folder'
```

### 3. Exit Code Interceptor (`clit why`)
Diagnoses recent command syntax issues and kernel failure states:

```bash
clit why
```

### 4. Production Chaos Drills (`clit drill <name>`)
Runs deterministic kernel invariant tests:

```bash
clit drill tar_omission
```

---

## 🏗️ Architecture

- **`src/cow.zig`**: Direct Darwin `libc.clonefile` APFS bindings & Linux `FICLONE` reflink support.
- **`src/pty.zig`**: Bidirectional non-blocking `poll(2)` multiplexer with `login_tty` controlling session allocation.
- **`src/guides.zig`**: Comptime `@embedFile` registry packing 16 manuals into `.rodata` (~284 KB binary total).
- **`src/verify.zig`**: Direct kernel state validation bypassing stdout regexes.
- **`src/syntax/dict.zig` & `lexer.zig`**: Zero-allocation linear POSIX lexer & compile-time flag dictionary.

---

## 📜 License

MIT License.
