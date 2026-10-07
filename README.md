<div align="center">

# ⚡ CLITutor (`clit`) ⚡

```text
   ____ _     ___ _____ utor
  / ___| |   |_ _|_   _|   
 | |   | |    | |  | |     
 | |___| |___ | |  | |     
  \____|_____|___| |_|   ZERO-OVERHEAD KERNEL ENGINE
```

### 🔮 *A Complete CLITorial for Advanced Terminal & Agentic Operations*

> **"Finally, a zero-overhead kernel engine to eliminate the ambiguity, cognitive fatigue, and footguns of modern CLI tooling—once and for all."**

---

[![Language](https://img.shields.io/badge/Language-Zig_0.17.0-F7A41D?style=for-the-badge&logo=zig&logoColor=white)](https://ziglang.org)
[![Binary Size](https://img.shields.io/badge/Binary_Size-284_KB-success?style=for-the-badge&logo=speedtest&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![Engine](https://img.shields.io/badge/Filesystem-APFS_%2F_Reflink_CoW-blue?style=for-the-badge&logo=apple&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![Latency](https://img.shields.io/badge/Startup_Latency-%3C_2ms-purple?style=for-the-badge&logo=lightning&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-macOS_%7C_Linux-black?style=for-the-badge&logo=apple)](https://github.com/ivybe1337/CLITutor)

<p align="center">
  <a href="#-why-clitutor">Why CLITutor</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-the-16-definitive-noob-to-pro-manuals">16 Built-in Manuals</a> •
  <a href="#-features--workflows">Core Features</a> •
  <a href="#-comparison-matrix">Comparison Matrix</a> •
  <a href="#-kernel-architecture">Architecture</a>
</p>

---

</div>

## 🌌 Why CLITutor?

Modern software engineering moves at breakneck speed: one moment you're debugging **PyTorch** tensors on Apple Silicon Metal shaders, the next you're deploying serverless GPUs with **Modal**, orchestrating **uv** Python environments, or wrestling with **Git**, **Bun**, and agentic CLIs like **Claude Code** and **Codex**.

Traditional manpages (`man`) are written in dense, unreadable 1980s POSIX legalese. Cheatsheets (`tldr`) give you three blind copy-paste lines without teaching you the mental model. Worse: one typo in a destructive command (`rm`, `rsync --delete`, `git reset --hard`) can destroy days of work.

**CLITutor (`clit`) bridges the divide:**
1. **Sub-2ms APFS / Reflink CoW Sandbox REPL**: Spawn an isolated subshell where every disk write is backed by a native copy-on-write snapshot. Test whatever you want; modifications vanish upon exit.
2. **Ghost Mode Pre-Flight Simulator**: Dry-run risky commands before execution, inspecting flag ASTs and OS kernel mutation diffs without touching your real project tree.
3. **16 Embedded "For-Dummies" Manuals**: Zero network requests, zero disk lookups. 16 full-length, hyper-practical guides compiled straight into the `.rodata` section of a 284 KB static binary.
4. **Deterministic Kernel Invariant Verifier**: Direct kernel-level verification of inodes, open file descriptors, and in-memory tar headers without brittle stdout parsing.

---

## ⚡ Quick Start

### 1. Build and Install (Zig 0.17.0)

```bash
git clone https://github.com/ivybe1337/CLITutor.git
cd CLITutor
zig build -Drelease -p ~/.local
```

Ensure `~/.local/bin` is in your `$PATH` (e.g., in `~/.zshrc` or `~/.bashrc`):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

### 2. Immediate Superpowers

```bash
# Open any guide instantly in your preferred terminal pager (bat / less / terminal)
clit torch            # PyTorch: Tensors, CUDA vs MPS Apple Silicon, CUDA one-liners
clit uv               # Astral uv: The 4 modes, pip replacement, venvs, zero disk drain
clit llamacpp         # llama.cpp: Local GGUF models, context sizes, GPU layers
clit modal            # Modal Labs: Serverless cloud GPUs in 3 lines of Python

# Launch the Copy-on-Write Sandbox REPL
clit repl

# Ghost Mode: Simulate a dangerous command inside an instant CoW sandbox
clit preview "find . -name '*.pyc' -delete && touch built.done"
```

---

## 📖 The 16 Definitive "Noob-to-Pro" Manuals

Every guide is baked directly into `clit`. Access them instantly with `clit <tool>` or `clit guide <tool>`:

| Category | Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- | :--- |
| **Deep Learning & Inference** | `clit torch` | **PyTorch (Deep Learning & Accelerators)** | Tensors, CUDA vs Apple Silicon MPS (`mps`), autograd, zero-panic device boilerplate. |
| | `clit llamacpp` | **llama.cpp (Local GGUF LLM Engine)** | Local quantizations (Q4/Q8), `-ngl` GPU offloading, context length, CLI flags. |
| **Cloud & GPU Scale** | `clit modal` | **Modal Labs (Serverless Cloud GPUs)** | Fast cloud functions, GPU decorators (`A100`, `T4`), shared network volumes. |
| | `clit colab` | **Google Colab (Cloud Notebooks)** | Free GPU runtimes, Google Drive mounting, terminal access, package persistence. |
| | `clit kaggle` | **Kaggle (Datasets & Kernels)** | Kaggle CLI, downloading multi-GB datasets, automated kernel submissions. |
| | `clit aws` | **AWS CLI (Amazon Cloud Infrastructure)** | S3 buckets, sync vs cp, EC2 instances, credentials, profile switching without leaks. |
| **Modern Toolchains & Runtimes** | `clit uv` | **Astral uv (Fast Python Substrate)** | The 4 UV modes, `uv tool` vs `uv pip`, global interpreters, eliminating duplicate packages. |
| | `clit bun` | **Bun & TypeScript (All-in-One Engine)** | `bun run`, `bun test`, `bun install` vs `npm`/`pnpm`, TypeScript execution without `tsc`. |
| | `clit brew` | **Homebrew (macOS / Linux Systems)** | Formulae vs Casks, brew services, disk cleanup, resolving path collisions. |
| **Systems Programming** | `clit zig` | **Zig Toolchain (Systems Programming)** | `build.zig`, C interop with zero overhead, comptime, cross-compilation matrix. |
| | `clit cargo` | **Rust & Cargo (Safe Systems)** | Crates, workspaces, release flags, clippy linting, cargo tree dependency debugging. |
| | `clit swift` | **Swift (Apple Platforms & CLI)** | Swift Package Manager (`spm`), release builds, native macOS automation scripts. |
| **Agentic AI & Coding Assistants** | `clit claude` | **Claude Code (Anthropic Agentic CLI)** | Multi-turn coding loops, prompt flags, bash integration, architecture workflows. |
| | `clit codex` | **OpenAI Codex / LLM CLI Interfaces** | Prompt evaluation, streaming terminal responses, token economy. |
| | `clit gemini` | **Google Gemini CLI & API Ecosystem** | Gemini 1.5/2.0 API calls, multimodal processing, developer keys. |
| **Source Control & Collaboration** | `clit git` | **Git & GitHub CLI (`gh`)** | Branch management, atomic commits, PR workflows, resolving merge conflicts safely. |

---

## 🛠️ Comparison Matrix

| Capability | Standard `man` | `tldr` / Cheat | `clit` (CLITutor) |
| :--- | :---: | :---: | :---: |
| **Readability** | ❌ Dense technical jargon | ⚠️ Shallow snippets | ✅ **Crystal-clear mental models & "For Dummies" workflows** |
| **Execution Safety** | ❌ None | ❌ None | ✅ **Pre-flight Ghost Simulator (`clit preview`)** |
| **Sandbox Playground** | ❌ None | ❌ None | ✅ **Native APFS / Linux Reflink CoW REPL (`clit repl`)** |
| **Disk & Dependency Overhead** | ⚠️ Manpaths & groff | ⚠️ Python / Node / Rust | ✅ **Single standalone 284 KB static binary** |
| **Offline Independence** | ⚠️ System-dependent | ❌ Needs cache sync | ✅ **100% Embedded in `.rodata`** |
| **Kernel State Auditing** | ❌ None | ❌ None | ✅ **Deterministic Inode & Mode Verifier (`clit drill`)** |
| **Subshell Responsiveness** | N/A | N/A | ✅ **Bidirectional non-blocking `poll(2)` PTY Multiplexer** |

---

## 🛡️ Core Features & Workflows

### 1. ⚡ Ghost Mode Pre-Flight Simulator (`clit preview <cmd>`)
Ever hesitated before hitting Enter on a destructive command? 
`clit preview` takes a **sub-2ms hardware copy-on-write clone** of your current working directory, executes the command headlessly inside the isolated sandbox, tokenizes and AST-lexes all flags to identify hazardous operations, and emits a live diff of modified inodes before destroying the sandbox:

```bash
$ clit preview 'tar -czf dist.tar.gz src/ && rm -rf old_build/'

⚡ [Ghost Mode] Taking sub-2ms APFS CoW snapshot of /workspace...
🚀 Executing command in isolated sandbox: /tmp/clit_sb_49182

📋 [AST Telemetry / Flag Deconstruction]:
   Tool: tar
   Flag -c: Create new archive
   Flag -z: Filter through gzip compression
   Flag -f: Specify archive target file
   Tool: rm
   Flag -r: Recursive deletion
   ⚠️ WARNING: Deletes entire directory hierarchies permanently

✅ Sandbox execution complete. Inspecting kernel mutations:
   [+] Mutation created: dist.tar.gz
   [-] Mutation deleted: old_build/
🧹 Unlinking sandbox: Zero side-effects applied to real project.
```

### 2. 🔒 Copy-on-Write Sandbox REPL (`clit repl`)
Step into a fully interactive pseudo-terminal session inside an APFS copy-on-write sandbox. Install experimental packages, compile experimental code, test crazy refactors:

```bash
$ clit repl
⚡ Initializing Sandbox PTY inside /workspace...
🔒 APFS CoW snapshot active: modifications are completely isolated.

sandbox $ echo "Messing with configs..." >> config.json
sandbox $ exit

# Host directory remains completely untouched!
```

### 3. 🎯 Deterministic Kernel Invariant Drills (`clit drill`)
Verify OS physical side-effects bypassing stdout regex matching completely:
- `tar_omission`: Validates in-memory UStar tar header streams to ensure secrets (`.env`, credentials) are omitted without disk extraction.
- `perm_lock`: Probes kernel permission bitmasks (`st_mode`) directly via `fstatat`.

```bash
clit drill tar_omission
```

---

## 🧬 Kernel Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                      CLITutor Engine                        │
├──────────────────────────────┬──────────────────────────────┤
│       macOS (Darwin)         │         Linux (POSIX)        │
├──────────────────────────────┼──────────────────────────────┤
│  libc.clonefile() / APFS     │  ioctl(dst_fd, FICLONE, ...) │
│  Darwin login_tty()          │  openpty() + login_tty()     │
│  proc_pidinfo() Descriptors  │  /proc/<pid>/fd Scanner      │
└──────────────────────────────┴──────────────────────────────┘
                               │
               ┌───────────────┴───────────────┐
               ▼                               ▼
       PtySession RingBuffer           Comptime Guides
    Bidirectional poll(2) Loop        Embedded in .rodata
         (Sub-2ms Latency)             (Zero Path Lookup)
```

- **Zero Runtime Allocations in Fast Paths**: Command tokens and flag dictionaries are resolved compile-time into static `.rodata`.
- **Pure Native Systems Language**: Written in 100% idiomatic Zig with clean POSIX/Darwin C-ABI bindings.
- **Microscopic Footprint**: Stripped release binary compiles to only **~284 KB**.

---

## 📄 License

Distributed under the **MIT License**. Crafted with precision by [ivybe1337](https://github.com/ivybe1337).
