# 🧪 pytest for Dummies: The No-Panic Manual

> **One sentence summary:** `pytest` makes writing and running Python unit tests painless with simple `assert` statements, powerful dependency-injection fixtures, and rich failure tracebacks.

---

## 🧠 The 3 Golden Concepts

1. **Plain `assert`**: You don't need `self.assertEqual(...)` or boilerplate classes. Just write `assert result == 42` and pytest gives you detailed diffs when it fails.
2. **Fixtures (`@pytest.fixture`)**: Reusable setup functions (e.g. database connections, mock clients, test data) that are automatically passed to test functions by name.
3. **Filtering (`-k`)**: Run only the tests you care about by matching substrings in test function names without having to type file paths.

---

## ⚡ The Daily 80/20 Commands

```bash
# Run all tests in the project
pytest

# Run a specific test file
pytest tests/test_auth.py

# Run only tests matching a name pattern (-k)
pytest -k "test_login or test_logout"

# Stop immediately on the first failure (-x) and show print statements (-s)
pytest -x -s

# Drop into interactive Python debugger (PDB) on failure (--pdb)
pytest --pdb

# Re-run only the tests that failed in the last run (--lf)
pytest --lf
```

---

## ⚡ 5-Line Fixture Example

```python
import pytest

@pytest.fixture
def sample_user():
    return {"id": 1, "username": "joshua", "is_admin": True}

def test_user_admin(sample_user):
    assert sample_user["is_admin"] is True
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Print output hidden**:
  * *Confusion:* Your `print("debug")` statements don't appear in the terminal during passing tests.
  * *Fix:* Pass `-s` (disable stdout capture) to see all live prints.
* **Footgun: Tests sharing mutable fixture state**:
  * *Fix:* By default, fixtures have function scope (re-created for each test). Don't accidentally set `scope="session"` on fixtures that mutate data.
