# 🦀 Cargo & Rust for Dummies: The No-Panic Manual

> **One sentence summary:** Rust is a memory-safe, ultra-fast language without a garbage collector, and `cargo` is its official build tool, package manager, and test runner that makes developing in Rust a delight.

---

## 🧠 The Mental Model: The Anatomy of a Rust Project

When you work with Rust, you almost never call `rustc` directly. You interact 100% through `cargo`:

```
my-project/
├── Cargo.toml      <-- Project manifest & dependencies (like package.json)
├── Cargo.lock      <-- Pinned exact dependency versions (like bun.lock)
└── src/
    └── main.rs     <-- Your code entrypoint
```

---

## 🛠️ Everyday Workflows

### 1. Creating a New Project
```bash
# Create a new executable app:
cargo new my-app
cd my-app

# Create a library project (no main.rs):
cargo new --lib my-library
```

### 2. The #1 Pro Tip: Use `cargo check` Constantly!
Compiling Rust can take time. Instead of waiting for `cargo build` while writing code, run `cargo check`.
It checks your types, syntax, and borrow checker rules **instantly** without building the final binary:
```bash
cargo check
```

### 3. Running & Building
```bash
# Compile and run immediately in debug mode:
cargo run

# Pass arguments to your program (use -- separator):
cargo run -- --port 8080 --verbose

# Build a release binary (fully optimized for maximum speed):
cargo build --release
# The final executable is saved at: ./target/release/my-app
```

### 4. Adding Dependencies (Crates)
Don't edit `Cargo.toml` manually by hand—use `cargo add`:
```bash
# Add a popular JSON crate:
cargo add serde --features derive

# Add async runtime:
cargo add tokio --features full

# Add HTTP client:
cargo add reqwest --features json
```

### 5. Your Best Friend: `cargo clippy`
Clippy is Rust’s built-in linter. It is like having a senior Rust engineer review your code and give you friendly suggestions on how to make it faster and cleaner:
```bash
cargo clippy
```

---

## 💾 Disk Space Hygiene: The `target/` Folder Warning

Every time you build in Rust, intermediate compiled files are stored in `./target/`. Over time, a single Rust project can grow to **5–15 GB**!

```bash
# Clean up compiled files and reclaim gigabytes of disk space:
cargo clean

# Check size of target directory:
du -sh target/
```

---

## ⚡ Everyday Cheat Sheet

| Command | What It Does |
| :--- | :--- |
| `cargo new <name>` | Creates a new Rust project |
| `cargo check` | Fast syntax/type verification (saves huge time) |
| `cargo run` | Builds & runs in debug mode |
| `cargo run --release` | Runs optimized release build |
| `cargo build --release` | Generates final binary in `./target/release/` |
| `cargo add <crate>` | Adds dependency to `Cargo.toml` |
| `cargo test` | Runs all unit and integration tests |
| `cargo clippy` | Lints code and suggests performance fixes |
| `cargo clean` | Deletes `./target/` to free disk space |
| `rustup update` | Updates Rust compiler to latest version |
