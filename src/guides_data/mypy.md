# 📐 mypy for Dummies: The No-Panic Manual

> **One sentence summary:** `mypy` is an optional static type checker for Python that catches `TypeError` and `AttributeError` bugs before you ever run your code, bringing compiled-language safety to dynamic Python.

---

## 🧠 The 3 Golden Concepts

1. **Type Hints**: Adding annotations like `name: str` and `def add(x: int, y: int) -> int:` doesn't change how Python runs; it allows mypy to statically prove correctness.
2. **`Optional[T]` / `T | None`**: In modern Python (3.10+), `name: str | None` prevents "NoneType has no attribute" bugs by forcing you to check `if name is not None:` before using it.
3. **Gradual Typing**: You don't have to type-check your entire codebase overnight; mypy checks whatever annotations you provide.

---

## ⚡ The Daily 80/20 Commands

```bash
# Type check a file or directory
mypy src/

# Run in strict mode (enforces type hints on all functions)
mypy --strict src/

# Ignore missing type stubs for untyped third-party libraries
mypy --ignore-missing-imports src/
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: `error: Library stubs not installed`**:
  * *Fix:* Install community type stubs: `uv pip install types-requests types-PyYAML` or add `# type: ignore` on specific import lines.
* **Footgun: Incompatible return types in branches**:
  * *Fix:* If a function returns an integer on success and `None` on failure, annotate it as `-> int | None`, not `-> int`.
