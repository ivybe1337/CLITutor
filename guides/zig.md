# ⚡ Zig for Dummies: The No-Panic Manual

> **One sentence summary:** Zig (`zig`) is a modern, ultra-fast systems programming language designed to replace C. It has no hidden control flow, no macros, no hidden memory allocations, and has the best cross-compiler on earth built directly into it.

---

## 🧠 The 3 Golden Rules of Zig

1. **No Hidden Control Flow:** There are no operator overloads, no hidden constructors, and no hidden exceptions. If you read a line of Zig, you know *exactly* what CPU instructions it runs.
2. **Explicit Memory Allocation:** If a function needs heap memory, it **must** take an `Allocator` as an argument. You always know where memory is allocated and who is responsible for freeing it.
3. **`comptime`:** Instead of messy preprocessor macros (like `#define` in C), Zig lets you run regular Zig code at compile time!

---

## 🛠️ Everyday Workflows

### 1. Run a File Directly (Like Python/Scripting)
You don't need a project setup to experiment with Zig:
```bash
zig run main.zig
```

### 2. Minimal Working "Hello World"
Create `main.zig`:
```zig
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("🚀 Hello from Zig!\n", .{});
}
```
Run it:
```bash
zig run main.zig
```

### 3. Understanding the Allocator Pattern
In Zig, you explicitly create an allocator and use `defer` to clean up:
```zig
const std = @import("std");

pub fn main() !void {
    // 1. General Purpose Allocator (catches memory leaks!)
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit(); // Automatically runs at end of main()
    const allocator = gpa.allocator();

    // 2. Allocate an array of 5 integers
    const numbers = try allocator.alloc(i32, 5);
    defer allocator.free(numbers); // Automatically frees memory

    numbers[0] = 42;
    std.debug.print("Value: {d}\n", .{numbers[0]});
}
```

### 4. Creating and Building a Project
```bash
# 1. Initialize a new project:
mkdir my-zig-app && cd my-zig-app
zig init

# 2. Build and run:
zig build run

# 3. Run unit tests:
zig build test

# 4. Build an optimized release binary:
zig build -Doptimize=ReleaseFast
# Output binary lands in: ./zig-out/bin/my-zig-app
```

### 5. Zig's Secret Superpower: The Universal C Compiler
Zig can compile any C or C++ file for any target architecture without installing Xcode tools or GCC:
```bash
# Compile a C file with Zig:
zig cc main.c -o myapp

# Cross-compile for Linux from your Mac with zero setup:
zig cc -target x86_64-linux main.c -o myapp-linux
```

---

## ⚡ Everyday Cheat Sheet

| Command | What It Does |
| :--- | :--- |
| `zig run <file.zig>` | Compiles and runs a single file immediately |
| `zig build-exe <file.zig>` | Compiles a single file into an executable |
| `zig init` | Scaffolds a new project (`build.zig` + `src/`) |
| `zig build` | Compiles the project |
| `zig build run` | Compiles and executes the project |
| `zig build test` | Executes all `test` blocks |
| `zig build -Doptimize=ReleaseFast` | High-performance release build |
| `zig cc` / `zig c++` | Drop-in modern C/C++ cross compiler |
| `zig version` | Prints current compiler version |
