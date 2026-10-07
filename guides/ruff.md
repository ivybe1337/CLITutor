# 🏎️ Ruff for Dummies: The No-Panic Manual

> **One sentence summary:** `ruff` is an extremely fast Python linter and code formatter written in Rust that completely replaces Black, Flake8, isort, and Bandit, running 10-100x faster than traditional tools.

---

## 🧠 The 3 Golden Concepts

1. **All-in-One Replacement**: You don't need `flake8` for linting, `isort` for import sorting, and `black` for formatting. `ruff` does all three in milliseconds.
2. **`ruff check` vs `ruff format`**:
   * `ruff check`: Analyzes your code for syntax errors, unused imports, security warnings, and styling issues.
   * `ruff format`: Rewrites your code to adhere to Black-compatible formatting style.
3. **Automatic Fixing (`--fix`)**: Ruff doesn't just complain about bugs; with `--fix`, it automatically rewrites and repairs the errors for you.

---

## ⚡ The Daily 80/20 Commands

```bash
# 1. Lint the current directory
ruff check .

# 2. Automatically fix all repairable issues (unused imports, sorting)
ruff check --fix .

# 3. Format all code files (replaces Black)
ruff format .

# 4. Check formatting without modifying files (great for CI/CD)
ruff format --check .

# 5. Lint and watch files for instant feedback on save
ruff check --watch .
```

---

## ⚙️ The Minimal `pyproject.toml` Configuration

Add this to your project's `pyproject.toml`:
```toml
[tool.ruff]
line-length = 88
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "I", "UP"] # Errors, Pyflakes, isort, PyUpgrade
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Forgetting `--fix`**:
  * *Fix:* Don't waste time manually deleting unused imports or reordering lines. Let `ruff check --fix` do it instantly!
