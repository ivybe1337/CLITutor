# 🦇 bat for Dummies: The No-Panic Manual

> **One sentence summary:** `bat` is a cat clone with syntax highlighting for 100+ programming languages, line numbers, Git modifications markers in the gutter, and automatic terminal paging.

---

## 🧠 The 3 Golden Concepts

1. **Syntax Highlighting by File Extension**: Unlike standard `cat` that dumps monochromatic walls of text, `bat` automatically detects syntax for `.py`, `.zig`, `.rs`, `.json`, `.yaml`, etc.
2. **Git Diff Gutter**: Lines added, modified, or deleted in your working tree display `+`, `~`, or `-` markers directly in the left gutter.
3. **Smart Paging**: If a file is longer than one terminal screen, `bat` automatically pipes it into `less` so your scrollback buffer isn't flooded; if it's short, it prints directly to stdout.

---

## ⚡ The Daily 80/20 Commands

```bash
# Pretty-print any file with line numbers and syntax
bat main.zig

# Print only specific line ranges (great for reviewing functions)
bat --line-range 50:100 server.py

# Plain mode without borders/headers (ideal for piping into other tools)
bat --style=plain script.sh

# Force syntax highlighting for files without standard extensions
bat -l json settings.local
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Paging when piping into commands**:
  * *Behavior:* `bat` is smart—when you pipe its output (`bat file.txt | grep foo`), it automatically disables paging, color, and line numbers so it acts exactly like POSIX `cat`.
