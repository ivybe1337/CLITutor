# 🐍 UV & Python for Dummies: The No-Panic Manual

> **One sentence summary:** `uv` is a blazingly fast all-in-one Python manager written in Rust that completely replaces old tools like `pip`, `virtualenv`, `poetry`, and `pyenv`.

---

## 🧠 The Mental Model: Understand the 4 Modes

The #1 reason people get confused with `uv` is trying to treat everything like standard `pip`. `uv` has 4 distinct powers:

```
┌────────────────────────────────────────────────────────────────────────┐
│                          THE 4 MODES OF UV                             │
├──────────────────┬─────────────────┬──────────────────┬────────────────┤
│ 1. Project Sync  │ 2. Tool Mode    │ 3. Direct Pip    │ 4. Run Mode    │
│    (Recommended) │    (CLI apps)   │    (Venv parts)  │    (Ad-hoc)    │
│                  │                 │                  │                │
│ uv init          │ uv tool install │ uv pip install   │ uv run         │
│ uv add <pkg>     │ modal, ruff,    │ torch, numpy     │ script.py      │
│ uv sync          │ kaggle          │ into active venv │ --with requests│
└──────────────────┴─────────────────┴──────────────────┴────────────────┘
```

### 1. `uv tool` = The App Store for CLI Programs
* **What it is:** When you want a standalone program that you run in your terminal (like `ruff`, `kaggle`, `modal`, `posting`, `torchrun`).
* **Why use it:** It installs each program into its own completely isolated bubble under `~/.local/share/uv/tools/` and puts a single shortcut in `~/.local/bin/`.
* **Golden Rule:** **NEVER** install developer libraries (like `numpy`, `pandas`, `torch`) with `uv tool`. Only install command-line utilities.

### 2. `uv pip` = The Engine Mechanic
* **What it is:** A drop-in, 10x-to-100x faster replacement for standard `pip install`.
* **Where packages go:** It installs packages into your currently active virtual environment (`.venv`), or if none is active, into your canonical `~/.uv-global` environment.
* **Golden Rule:** Use this when working in an existing codebase or script directory where you just need to `pip install <something>`.

### 3. `uv run` = The "Just Make It Work" Runner
* **What it is:** Executes a Python script or command using the right environment automatically, without needing you to manually run `source .venv/bin/activate`.
* **Magic superpower:** You can run a one-off script with dependencies you don't even have installed:
  ```bash
  uv run --with requests --with rich python -c "import requests; print('Works instantly!')"
  ```

### 4. `uv init` & `uv add` = Modern Projects
* **What it is:** How modern Python projects manage dependencies using `pyproject.toml` and `uv.lock`.
* You say `uv add fastapi` and it adds it to your project, locks the exact version, and updates `.venv` automatically.

---

## 🛠️ Everyday Workflows: Step-by-Step

### Scenario A: Starting a New Project from Scratch
```bash
# 1. Create a project folder and enter it
mkdir my-ai-project && cd my-ai-project

# 2. Initialize a uv project (creates pyproject.toml and .python-version)
uv init

# 3. Add packages you need
uv add torch numpy

# 4. Run your code!
uv run python main.py
```

### Scenario B: Working in an Existing Folder / Simple Scripts
```bash
# 1. Create a virtual environment (.venv)
uv venv

# 2. Activate it (so your terminal knows where packages live)
source .venv/bin/activate

# 3. Install packages
uv pip install -r requirements.txt
# OR
uv pip install torch torchvision

# 4. Run your code
python main.py
```

### Scenario C: Installing Global Terminal Tools
```bash
# Install a tool globally
uv tool install ruff
uv tool install modal
uv tool install kaggle

# List installed tools
uv tool list

# Upgrade a tool
uv tool upgrade modal

# Remove a tool
uv tool uninstall modal
```

---

## 🐍 Managing Python Versions (Without Pyenv)

`uv` downloads and manages official standalone Python versions without messing up macOS system files.

```bash
# See which Python versions are available and installed
uv python list

# Install a specific Python version
uv python install 3.12

# Pin a specific Python version for the current folder
uv python pin 3.12

# Find the path to the current uv-managed Python
uv python find
```

---

## 💾 Storage & Disk Space Hygiene

If you are dealing with large AI packages (like PyTorch wheels which are ~2.5 GB each):

1. **APFS Cloning (`link-mode = "clone"`):**
   * Configured in your `~/.config/uv/uv.toml`.
   * When `uv` downloads a package, it caches it in `~/.cache/uv`.
   * When you install it into 3 different project virtualenvs, APFS creates **copy-on-write clones**. It uses **zero additional disk bytes**!
2. **Clean up old dangling downloads:**
   ```bash
   uv cache prune
   ```
3. **Check how much cache uv is using:**
   ```bash
   du -sh ~/.cache/uv
   ```

---

## ⚡ Everyday Cheat Sheet

| Task | What to Type |
| :--- | :--- |
| Start Python REPL | `python` (or `uv run python`) |
| Run a script | `python script.py` or `uv run python script.py` |
| Create a virtualenv | `uv venv` |
| Activate virtualenv | `source .venv/bin/activate` |
| Deactivate virtualenv | `deactivate` |
| Fast install a package | `uv pip install <package>` |
| Install requirements.txt | `uv pip install -r requirements.txt` |
| List installed packages | `uv pip list` |
| Freeze requirements | `uv pip freeze > requirements.txt` |
| Install a global CLI tool | `uv tool install <app>` |
| Upgrade a CLI tool | `uv tool upgrade <app>` |
| Run temporary one-liner | `uv run --with <pkg> python -c "..."` |
| Clean up unused cache | `uv cache prune` |
