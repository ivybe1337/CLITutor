# ⚡ zoxide (z) for Dummies: The No-Panic Manual

> **One sentence summary:** `zoxide` is a smarter, faster replacement for the `cd` command that tracks your most frequently and recently used folders so you can jump anywhere on your system by typing a couple of letters.

---

## 🧠 The 3 Golden Concepts

1. **Frecency**: Combines *Frequency* (how often you visit a folder) and *Recency* (how recently you visited it) into an algorithm that ranks your destination choices.
2. **Fuzzy Directory Matching**: Instead of typing `cd /Users/joshua/LocalBuilds/CLITutor/src/guides`, you just type `z gui` and press Enter.
3. **Interactive Menu (`zi`)**: When multiple folders match your search string, `zi` opens an interactive `fzf` menu allowing you to choose the exact folder.

---

## ⚡ The Daily 80/20 Commands

```bash
# Jump directly to best match
z clit

# Jump to a folder containing multiple keywords
z local tutor

# Open interactive selector
zi

# Jump to parent directory
z ..
```

---

## 🛑 Setup One-Liner

Ensure zoxide hooks into your shell by adding this to `~/.zshrc`:
```bash
eval "$(zoxide init zsh)"
```
Or in `~/.bashrc`:
```bash
eval "$(zoxide init bash)"
```
