# 🔍 fzf for Dummies: The No-Panic Manual

> **One sentence summary:** `fzf` is a general-purpose command-line fuzzy finder that lets you instantly search, filter, and interact with files, command history, git branches, and piped text in real-time as you type.

---

## 🧠 The 3 Golden Concepts

1. **Interactive Filter**: `fzf` reads text lines from STDIN, gives you an interactive fuzzy-search prompt, and prints whatever line you choose to STDOUT.
2. **Terminal Shell Keybindings**:
   * `Ctrl-r`: Instant fuzzy search of your entire shell command history (replaces clumsy bash history searches).
   * `Ctrl-t`: Fuzzy search files in the current folder and paste the chosen path into your command line.
   * `Alt-c`: Fuzzy jump into a sub-directory.
3. **Piping Any Command into fzf**: If a command emits a list of things (files, processes, git commits), you can pipe it into `fzf` to make it interactive.

---

## ⚡ The Top 5 Life-Changing One-Liners

```bash
# 1. Open any file in your editor interactively
vim $(fzf)

# 2. Interactive kill process: search process name and terminate it
kill -9 $(ps aux | fzf | awk '{print $2}')

# 3. Interactive Git Checkout (switch branch by fuzzy typing)
git checkout $(git branch -a | fzf | tr -d '[:space:]*')

# 4. Preview files with syntax highlighting while searching
fzf --preview 'bat --style=numbers --color=always --line-range :100 {}'

# 5. Search git commit history with full commit diff preview
git log --oneline | fzf --preview 'git show {1}'
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: fzf Indexing Massive `node_modules` or `.git`**:
  * *Fix:* Install `fd` or `ripgrep` and set:
    `export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'`
    in your `~/.zshrc`. Searches will be instantaneous and ignore junk.
