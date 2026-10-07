# 📂 eza for Dummies: The No-Panic Manual

> **One sentence summary:** `eza` is a modern, ultra-fast replacement for the traditional `ls` command, featuring vibrant file-type coloring, Git status integration, human-readable file sizes, and built-in tree views.

---

## 🧠 The 3 Golden Concepts

1. **Drop-in `ls` Upgrade**: Any flag you're used to (`-l`, `-a`, `-h`) works in `eza`, but with much prettier formatting and instant visual indicators.
2. **Git Status Column (`--git`)**: In long listing mode, `eza` shows whether a file is modified (`M`), staged (`A`), or untracked (`?`) right next to its file name.
3. **Built-in Tree View (`--tree`)**: Replaces the separate `tree` utility; visualize nested directory hierarchies with an optional depth limit.

---

## ⚡ The Daily 80/20 Aliases & Commands

```bash
# Detailed list with human file sizes, header, and git status
eza -lah --git

# Tree view of current directory up to 2 levels deep
eza --tree --level=2

# Sort by modification time (most recent files at bottom)
eza -l --sort=modified

# Group directories first
eza -l --group-directories-first
```

---

## 🛑 The Recommended Shell Alias

Put this in your `~/.zshrc` or `~/.bashrc`:
```bash
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -lah --icons=auto --git --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto'
```
