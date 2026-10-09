<div align="center">

# ⚡ CLITutor (`clit`) ⚡

```text
   ____ _     ___ _____ utor
  / ___| |   |_ _|_   _|   
 | |   | |    | |  | |     
 | |___| |___ | |  | |     
                       \____|_____|___| |_| ZERO-OVERHEAD KERNEL ENGINE
```

### 🔮 *A Complete CLITorial for Advanced Terminal Operations* 

> **"Eliminate the ambiguity, cognitive fatigue, and footguns of modern CLI tooling—once and for all."**

---

[![Language](https://img.shields.io/badge/Language-Zig_0.17.0-F7A41D?style=for-the-badge&logo=zig&logoColor=white)](https://ziglang.org)
[![Guides](https://img.shields.io/badge/Guides-51_Built--in_Manuals-red?style=for-the-badge&logo=bookstack&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![Binary Size](https://img.shields.io/badge/Binary_Size-348_KB-success?style=for-the-badge&logo=speedtest&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![Engine](https://img.shields.io/badge/Filesystem-APFS_%2F_Reflink_CoW-blue?style=for-the-badge&logo=apple&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![Latency](https://img.shields.io/badge/Startup_Latency-%3C_2ms-purple?style=for-the-badge&logo=lightning&logoColor=white)](https://github.com/ivybe1337/CLITutor)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-macOS_%7C_Linux-black?style=for-the-badge&logo=apple)](https://github.com/ivybe1337/CLITutor)

<p align="center">
  <a href="#-why-clitutor">Why CLITutor</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-the-51-definitive-noob-to-pro-manuals">51 Built-in Manuals</a> •
  <a href="#-features--workflows">Core Features</a> •
  <a href="#-comparison-matrix">Comparison Matrix</a> •
  <a href="#-kernel-architecture">Architecture</a>
</p>

---

</div>

## 🌌 Why CLITutor?

Modern software engineering moves at breakneck speed: one moment you're debugging **PyTorch** tensors on Apple Silicon Metal shaders, the next you're deploying serverless GPUs with **Modal**, spinning up containers in **Docker**, orchestrating **uv** Python environments, or wrestling with **Git**, **Bun**, and agentic CLIs like **Claude Code**, **Codex**, and **Aider**.

Traditional manpages (`man`) are written in dense, unreadable 1980s POSIX legalese. Cheatsheets (`tldr`) give you three blind copy-paste lines without teaching you the mental model. Worse: one typo in a destructive command (`rm`, `rsync --delete`, `git reset --hard`) can destroy days of work.

**CLITutor (`clit`) bridges the divide:**
1. **Sub-2ms APFS / Reflink CoW Sandbox REPL**: Spawn an isolated subshell where every disk write is backed by a native copy-on-write snapshot. Test whatever you want; modifications vanish upon exit.
2. **Ghost Mode Pre-Flight Simulator**: Dry-run risky commands before execution, inspecting flag ASTs and OS kernel mutation diffs without touching your real project tree.
3. **51 Embedded "For-Dummies" Manuals**: Zero network requests, zero disk lookups. 51 full-length, hyper-practical guides compiled straight into the `.rodata` section of a 348 KB static binary.
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
clit docker           # Docker: Containers, Volumes, Port Mappings, Compose
clit torch            # PyTorch: Tensors, CUDA vs MPS Apple Silicon, Device one-liners
clit uv               # Astral uv: The 4 modes, pip replacement, venvs, zero disk drain
clit tmux             # tmux: Background sessions, windows, splits, persistent tasks
clit duckdb           # DuckDB: In-process analytical SQL querying Parquet & CSV files
clit ffmpeg           # FFmpeg: Transcoding, compressing, trimming, gif conversion

# Launch the Copy-on-Write Sandbox REPL
clit repl

# Ghost Mode: Simulate a dangerous command inside an instant CoW sandbox
clit preview "find . -name '*.pyc' -delete && touch built.done"
```

---

## 📖 The 51 Definitive "Noob-to-Pro" Manuals

Every guide is baked directly into `clit`. Access them instantly with `clit <tool>` or `clit guide <tool>`:

### 🧠 Deep Learning, LLMs & GPU Kernel Engineering
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit torch` | **PyTorch** | Tensors, CUDA vs Apple Silicon MPS (`mps`), autograd, device boilerplate. |
| `clit llamacpp` | **llama.cpp** | Local quantizations (Q4/Q8), `-ngl` GPU offloading, context length, CLI flags. |
| `clit accelerate` | **HuggingFace Accelerate** | Multi-GPU distributed training, mixed precision (bf16), DeepSpeed, FSDP. |
| `clit transformers`| **Hugging Face Transformers**| Model hub, pipelines, AutoModel, quantizations, disk cache cleanup. |
| `clit ollama` | **Ollama** | Local model serving, Modelfiles, GPU offloading, OpenAI-compatible local API. |
| `clit vllm` | **vLLM** | High-throughput LLM serving, PagedAttention, continuous batching, AWQ. |
| `clit triton` | **OpenAI Triton** | Python GPU kernel programming, block vectors, pointers, `@triton.jit`. |

### ☁️ Cloud, Serverless & Infrastructure
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit modal` | **Modal Labs** | Serverless cloud GPUs, web functions, network volumes, A100/H100 compute. |
| `clit colab` | **Google Colab** | Cloud GPU runtimes, Google Drive mounting, terminal access, persistence. |
| `clit kaggle` | **Kaggle** | CLI dataset downloads, GPU kernels, automated competition submissions. |
| `clit aws` | **AWS CLI** | S3 buckets, sync vs cp, EC2 instances, credentials, profile switching. |
| `clit gcp` | **Google Cloud (gcloud)** | Project IDs, Application Default Credentials (ADC), Compute VMs, Storage. |
| `clit vercel` | **Vercel CLI** | Zero-downtime deployments, preview URLs, pulling remote `.env` variables. |
| `clit docker` | **Docker** | Images vs Containers, volumes, port forwarding, Dockerfiles, Compose. |
| `clit kubectl` | **Kubernetes (kubectl)** | Pods, Deployments, Services, Ingress, `CrashLoopBackOff` debugging. |
| `clit terraform` | **Terraform** | IaC declarative state, `plan` vs `apply`, state locking, preventing drift. |

### ⚡ Languages, Package Managers & Modern Toolchains
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit uv` | **Astral uv** | The 4 UV modes, `uv tool` vs `uv pip`, global interpreters, cache speed. |
| `clit bun` | **Bun & TypeScript** | Fast runtime, package manager, test runner, native TypeScript execution. |
| `clit pnpm` | **pnpm** | Content-addressable global hard-link store, eliminating duplicate modules. |
| `clit deno` | **Deno** | Secure-by-default runtime, permission flags, native TS, single binary builds. |
| `clit brew` | **Homebrew** | Formulae vs Casks, brew services, disk cleanup, resolving path collisions. |
| `clit zig` | **Zig** | `build.zig`, C-ABI interop, comptime, zero-allocation memory safety. |
| `clit cargo` | **Rust & Cargo** | Crates, release profiles, workspaces, clippy linting, cargo tree inspection. |
| `clit swift` | **Swift** | Swift Package Manager (`spm`), release binaries, native macOS scripts. |

### 💾 Data & Databases
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit duckdb` | **DuckDB** | In-process analytical SQL, Parquet/CSV querying, zero-copy Pandas bridge. |
| `clit sqlite3` | **SQLite (sqlite3)** | Single-file database, dot-commands (`.schema`, `.dump`), WAL mode. |
| `clit postgres` | **PostgreSQL (psql)** | Connection URIs, backslash commands (`\d`, `\x`), `EXPLAIN ANALYZE`. |
| `clit redis` | **Redis (redis-cli)** | In-memory key-value, hashes, queues, pub/sub, TTLs, avoiding `KEYS *`. |

### 🛠️ Developer Terminal Superpowers & Utilities
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit tmux` | **tmux** | Persistent background sessions, windows, splits, attach/detach workflows. |
| `clit fzf` | **fzf** | Interactive fuzzy finding, `Ctrl-R` history, `Ctrl-T` files, process killing. |
| `clit jq` | **jq** | JSON parsing, key access, array transforms, raw string extraction (`-r`). |
| `clit rg` | **ripgrep (rg)** | Ultra-fast regex search, smart-case, type filters (`-t`), ignoring junk. |
| `clit eza` | **eza** | Modern `ls` with Git status gutter, file icons, and hierarchical tree views. |
| `clit bat` | **bat** | Modern `cat` with syntax highlighting, line numbers, and Git diff gutters. |
| `clit zoxide` | **zoxide (z)** | Frecency-based directory jumping, fuzzy matching, interactive `zi`. |
| `clit ffmpeg` | **FFmpeg** | Video/audio transcoding, lossless trimming (`-c copy`), compression, GIFs. |
| `clit curl` | **curl** | HTTP methods (`-X`), custom headers (`-H`), JSON payloads, following redirects. |
| `clit rsync` | **rsync** | Delta-transfer sync, `-avzP` gold standard, trailing slash rules, dry-runs. |
| `clit ssh` | **SSH** | Ed25519 keypairs, `~/.ssh/config` profiles, port tunneling (`-L`). |
| `clit tar` | **tar** | Archiving (`-czf`), extracting (`-xzf`), preventing tar-bombs. |
| `clit lsof` | **lsof** | Finding who holds port 3000, killing hung processes, open socket tracking. |
| `clit nmap` | **Nmap** | Host discovery, port scanning, stealth SYN scans, service version detection. |

### 🐍 Python Quality & Modern Web APIs
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit ruff` | **Ruff** | Blazingly fast Rust linter & formatter, `--fix` auto-repairs, `pyproject.toml`. |
| `clit pytest` | **pytest** | Simple `assert`, dependency fixtures, `-k` filtering, debugging with `--pdb`. |
| `clit mypy` | **mypy** | Optional static typing, strict mode, union types (`T | None`), preventing bugs. |
| `clit fastapi` | **FastAPI** | Auto Pydantic validation, interactive Swagger docs, async endpoints. |

### 🤖 Agentic AI & Collaboration
| Command | Tool & Guide Title | Focus & Highlights |
| :--- | :--- | :--- |
| `clit claude` | **Claude Code** | Anthropic Agentic CLI toolchain, multi-turn coding loops, bash integration. |
| `clit codex` | **OpenAI Codex** | OpenAI LLM terminal interfaces, streaming token economy. |
| `clit gemini` | **Google Gemini** | Gemini developer CLI ecosystem, multimodal API endpoints. |
| `clit aider` | **Aider** | Terminal AI pair programmer, git-aware repository mapping, atomic commits. |
| `clit git` | **Git & GitHub CLI (`gh`)**| Atomic branching, merge conflicts, pull requests, releases, repo controls. |

---

## 🛠️ Comparison Matrix

| Capability | Standard `man` | `tldr` / Cheat | `clit` (CLITutor) |
| :--- | :---: | :---: | :---: |
| **Readability** | ❌ Dense technical jargon | ⚠️ Shallow snippets | ✅ **Crystal-clear mental models & "For Dummies" workflows** |
| **Execution Safety** | ❌ None | ❌ None | ✅ **Pre-flight Ghost Simulator (`clit preview`)** |
| **Sandbox Playground** | ❌ None | ❌ None | ✅ **Native APFS / Linux Reflink CoW REPL (`clit repl`)** |
| **Built-in Scope** | ⚠️ Tool-dependent | ⚠️ Limited examples | ✅ **51 Comprehensive modern manuals baked in** |
| **Disk & Dependency Overhead** | ⚠️ Manpaths & groff | ⚠️ Python / Node / Rust | ✅ **Single standalone 348 KB static binary** |
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
       PtySession RingBuffer           51 Comptime Guides
    Bidirectional poll(2) Loop        Embedded in .rodata
         (Sub-2ms Latency)             (Zero Path Lookup)
```

- **Zero Runtime Allocations in Fast Paths**: Command tokens and flag dictionaries are resolved compile-time into static `.rodata`.
- **Pure Native Systems Language**: Written in 100% idiomatic Zig with clean POSIX/Darwin C-ABI bindings.
- **Microscopic Footprint**: Stripped release binary compiles to only **~348 KB** containing all 51 full-text manuals.

---

## 📄 License

Distributed under the **MIT License**. Crafted with precision by [ivybe1337](https://github.com/ivybe1337).
