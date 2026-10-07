# 🍺 Homebrew for Dummies: The No-Panic Manual

> **One sentence summary:** Homebrew (`brew`) is the missing app store for macOS; it lets you install command-line utilities (formulae) and full graphical Mac apps (casks) with one simple terminal command.

---

## 🧠 The Mental Model: Formulae vs. Casks

```
┌────────────────────────────────────────────────────────────────────────┐
│                        HOMEBREW: TWO FLAVORS                           │
├───────────────────────────────────┬────────────────────────────────────┤
│ 1. Formulae (Command-Line Tools)  │ 2. Casks (Mac GUI Applications)    │
├───────────────────────────────────┼────────────────────────────────────┤
│ Installed into: /opt/homebrew/bin │ Installed into: /Applications/     │
│ Examples: git, bat, fzf, eza, zed │ Examples: google-chrome, docker    │
│ Command: brew install <name>      │ Command: brew install --cask <app> │
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 🛠️ Everyday Workflows

### 1. Installing Software
```bash
# Search for software:
brew search fzf

# Install a CLI tool:
brew install bat fzf eza

# Install a desktop GUI app:
brew install --cask visual-studio-code
brew install --cask raycast
```

### 2. Updating Your System Safely
Don't let software sit outdated for months:
```bash
# Step 1: Update the catalogue of package versions
brew update

# Step 2: Actually upgrade your outdated apps
brew upgrade

# Step 3: Reclaim gigabytes of disk space from old installer archives!
brew cleanup
```

### 3. Uninstalling Software Cleanly
```bash
# Uninstall a tool:
brew uninstall wget

# Uninstall a GUI app and remove its data:
brew uninstall --cask slack --zap
```

### 4. Background Services (Postgres, Redis, Ollama)
Homebrew can manage background system services without you opening extra terminal tabs:
```bash
# List all services and their status:
brew services list

# Start a background service:
brew services start redis

# Stop a background service:
brew services stop redis
```

---

## 🚨 The Top 2 Gotchas for Homebrew on Your Mac

1. **Avoid installing Python via Homebrew:**
   * On your machine, `uv` manages all Python versions with zero conflicts. Homebrew's pre-release Python can clash with macOS platform headers. Always rely on `uv` for Python.
2. **When Homebrew feels broken:**
   * Run the built-in diagnostic doctor:
     ```bash
     brew doctor
     ```
   * It tells you exactly what permissions or files need attention in plain English.
