# CLI / REPL Zero-Overhead Engine: Master Implementation Plan

## Phase 0: Compiler Discovery & Toolchain Invariant Audit (Pre-Execution Gate)
- [ ] Inspect local Zig compiler environment before writing any code:
      - Execute `zig version` and query active compilation targets.
      - Audit `std.Build` in standard library sources to confirm root module syntax.
      - Audit `std.posix` vs `std.c` exports to ensure zero references to deprecated `std.os`.
      - Confirm platform-specific PTY header locations (`<util.h>` on macOS vs `<pty.h>` + `-lutil` on Linux).
- [ ] Establish strict compiler flags in `build.zig`:
      - Default optimize mode: `ReleaseFast`.
      - Strip symbols where appropriate to guarantee executable stays under 2 MB.

## Phase 1: Baremetal CoW Sandbox & Terminal PTY
- [ ] Implement APFS / Linux Reflink Engine (`src/cow.zig`):
      - macOS: Bind Darwin `libc.clonefile` / `fclonefileat` via `@cImport`. Sub-2ms directory tree cloning.
      - Linux: Bind `ioctl(dst_fd, FICLONE, src_fd)` for Btrfs/XFS/ZFS reflink cloning.
      - Implement non-blocking background sandbox unlinking for sub-2ms cleanup cycles.
- [ ] Implement Baremetal PTY Multiplexer (`src/pty.zig`):
      - Allocate pseudo-terminal pair via `c.openpty()`.
      - Configure terminal raw mode via `std.c.tcsetattr` with `TCSANOW`.
      - Spawn user subshell (`$SHELL` or `/bin/sh`) inside the isolated sandbox directory using `std.posix.fork()` and `std.posix.execveZ()`.
      - Stream input/output through pre-allocated 64 KB ring buffers.

## Phase 2: Compile-Time Flag Registry & Zero-Allocation Lexer
- [ ] Compile-Time Flag Lookup Table (`src/syntax/dict.zig`):
      - Embed static dictionary structures directly into `.rodata` using Zig `comptime`.
      - Cover primary developer tools: `tar`, `find`, `grep`, `chmod`, `rsync`, `lsof`, `git`.
      - Map flags to long forms, semantic operations, and footgun warnings with zero runtime allocations.
- [ ] Linear POSIX Shell Lexer (`src/syntax/lexer.zig`):
      - Tokenize command strings in single-pass linear time O(N) directly over input byte slices.
      - Handle single/double quotes, escape characters, and combined short flags (e.g., `-czf` -> `-c`, `-z`, `-f`).

## Phase 3: Deterministic Kernel Invariant Verifier
- [ ] Direct Kernel State Engine (`src/verify.zig`):
      - Bypass stdout regex matching completely; verify physical side-effects on the OS kernel.
      - `assert_file_exists`: Direct `std.posix.fstatat` inode validation.
      - `assert_file_mode`: Direct bitmask check against `stat.st_mode`.
      - `assert_tar_omission`: Streaming in-memory UStar/POSIX tar/gzip parser reading file headers without disk extraction.
      - `assert_process_dead`: Direct probe via `std.c.kill(pid, 0) == -1` checking for `ESRCH`.
      - `assert_descriptor_reclaimed`: Scan open file descriptor tables via Darwin `proc_pidinfo` or Linux `/proc/<pid>/fd`.
- [ ] Mutation Diff Scanner:
      - Compare pre-command vs post-command directory tree states to emit instant visual tree diffs.

## Phase 4: Differential ANSI UI Matrix
- [ ] Double-Buffered Cell Grid (`src/ui/buffer.zig` & `src/ui/renderer.zig`):
      - Flat 1D terminal cell array: `Cell { codepoint: u21, fg: Color, bg: Color, attr: u8 }`.
      - Differential line flusher: Compare front vs back buffer and emit ANSI escape sequences (`\x1b[...]`) strictly for modified coordinate cells.
      - Maintain smooth 120 FPS frame timing; 0% CPU consumption while idling.
- [ ] UI Composition:
      - Header Pane (20%): Mission context, active invariants, drill rules.
      - PTY Terminal (55%): Interactive subshell pass-through.
      - Telemetry / AST Lens (25%): Real-time flag deconstruction & active open descriptor monitor.

## Phase 5: Developer Workflows & Monetization Primitives
- [ ] Ghost Mode Pre-Flight Simulator (`src/main.zig preview <cmd>`):
      - Instant APFS CoW directory snapshot to `/tmp`, headless execution inside sandbox, visual diff emission, sandbox destruction.
- [ ] Exit Code Interceptor (`src/main.zig why`):
      - Capture non-zero `$?` traps via shell hook, analyze failed command flags and kernel error states, output immediate diagnosis and corrected command.
- [ ] Production SRE Chaos Drills:
      - Seed scenarios for leaked file descriptors, unlinked active files, zombie processes, and locked ports.
- [ ] Cryptographic Competency Receipts:
      - Sign successful scenario completions using Ed25519 keypairs (`~/.clitutor/identity.key`).
