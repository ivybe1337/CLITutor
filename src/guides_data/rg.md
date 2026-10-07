# ⚡ ripgrep (rg) for Dummies: The No-Panic Manual

> **One sentence summary:** `rg` (ripgrep) is the fastest code-searching tool in existence, recursively searching directory trees for regex patterns in milliseconds while respecting `.gitignore` files automatically.

---

## 🧠 The 3 Golden Concepts

1. **Smart Case Sensitivity**: If your search query is all lowercase (`rg main`), it searches case-insensitively. If you include even one uppercase letter (`rg MainFunction`), it automatically switches to case-sensitive!
2. **Git-Aware by Default**: Unlike ancient `grep -r`, `rg` automatically ignores `.git/`, binary files, hidden files, and everything listed in your `.gitignore`.
3. **Type Filters (`-t`)**: Instead of searching every file, you can filter directly by programming language (e.g., `-t py`, `-t rust`, `-t zig`).

---

## ⚡ The Daily 80/20 Commands

```bash
# Basic search across current directory
rg "TODO"

# Case-insensitive search explicitly
rg -i "connect_timeout"

# Search strictly within Python files
rg -t py "class Model"

# Search with glob pattern (e.g. only inside test files)
rg -g "*_test.zig" "expectEqual"

# Show 3 lines of context around matches
rg -C 3 "NullPointerException"

# Search hidden files and gitignored files too
rg -u "SECRET_KEY"   # un-ignore gitignore
rg -uu "SECRET_KEY"  # search hidden + gitignored
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Forgetting ripgrep ignores hidden files by default**:
  * *Confusion:* `rg "API_KEY"` doesn't find anything because your key is in `.env` (a hidden file starting with a dot)!
  * *Fix:* Use `rg --hidden "API_KEY"`.
* **Footgun: Regex special character confusion**:
  * *Confusion:* Searching for `foo(bar)` searches for a regex group instead of literal parentheses.
  * *Fix:* Use `-F` (fixed strings / literal mode): `rg -F "foo(bar)"`.
