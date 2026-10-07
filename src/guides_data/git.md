# 🐙 Git & GitHub CLI (`gh`) for Dummies: The No-Panic Manual

> **One sentence summary:** `git` is the time machine for your code, and `gh` is the official GitHub command line that lets you clone repos, open pull requests, and view issues without ever opening a web browser.

---

## 🧠 The Mental Model: The 4 Rooms of Git

```
┌─────────────────┐      git add      ┌─────────────────┐    git commit    ┌─────────────────┐     git push     ┌─────────────────┐
│ 1. Working Room │ ────────────────> │ 2. Staging Room │ ───────────────> │ 3. Local Vault  │ ---------------> │ 4. GitHub Cloud │
│ (Files on disk) │                   │ (What's packed) │                  │ (History saved) │                  │ (Remote origin) │
└─────────────────┘                   └─────────────────┘                  └─────────────────┘                  └─────────────────┘
```

---

## 🛠️ Everyday Workflows

### 1. The Daily Save Cycle
```bash
# 1. Check what changed (clean short status)
git status -s

# 2. Stage changes (pack into the staging room)
git add .
# (or just one file: git add main.py)

# 3. Commit with a clear explanation
git commit -m "Add PyTorch MPS acceleration support"

# 4. Push to GitHub
git push
```

### 2. Branching (Work Safely Without Breaking `main`)
```bash
# Create and jump into a new branch:
git switch -c feature/new-loss-function
# (Old command: git checkout -b feature/new-loss-function)

# Switch back to main:
git switch main

# Pull latest updates cleanly (without messy merge bubbles):
git pull --rebase origin main

# Delete branch when finished:
git branch -d feature/new-loss-function
```

### 3. Stashing (Save Incomplete Work Temporarily)
Need to quickly switch branches but aren't ready to commit yet?
```bash
# Temporarily tuck away all current changes:
git stash

# Switch branches, do whatever you need:
git switch main

# Come back and restore your work:
git switch feature/my-work
git stash pop
```

---

## 🚀 GitHub CLI (`gh`): Supercharge Your Workflow

### 1. Initial Login
```bash
gh auth login
# Choose: GitHub.com -> HTTPS -> Login with a web browser
```

### 2. Clone Any Repository Instantly
Instead of copying URLs from the browser:
```bash
gh repo clone owner/repo-name
```

### 3. Open a Pull Request from Your Terminal
```bash
# Push your branch and open PR interactive wizard:
gh pr create --web
# (Opens the GitHub PR creation page with your diff already populated!)

# Or create directly from terminal:
gh pr create --title "Fix colab timeout" --body "Switched to local binary"
```

### 4. Review & Checkout Teammate PRs
```bash
# List open PRs:
gh pr list

# Check out someone else's PR locally to test their code:
gh pr checkout 42

# Watch GitHub Actions / CI run:
gh run watch
```

---

## 🚨 The "Oh Shit, Git!" Panic Room (Safe Fixes)

1. **"I made changes to a file and want to revert to how it was before":**
   ```bash
   git restore <filename>
   ```
2. **"I just made a commit and made a typo in the message":**
   ```bash
   git commit --amend -m "Corrected message"
   ```
3. **"I committed on the wrong branch! (Keep my code changes intact)":**
   ```bash
   # Undoes the commit but leaves all your modified code staged in your working directory:
   git reset --soft HEAD~1
   ```
4. **"I think I completely deleted or lost a commit!":**
   ```bash
   # Git keeps a hidden log of every single action for 30 days. You CANNOT lose code:
   git reflog
   # Find the commit hash from the list, then:
   git checkout <hash>
   ```

---

## ⚡ Everyday Cheat Sheet

| Command | What It Does |
| :--- | :--- |
| `git status -s` | Clean overview of changed files |
| `git diff` | Shows exact line additions/deletions |
| `git add .` | Stages all changes |
| `git commit -m "..."` | Records snapshot locally |
| `git push` | Uploads commits to GitHub |
| `git pull --rebase` | Downloads latest code cleanly |
| `git switch -c <name>` | Creates and enters new branch |
| `git stash` / `pop` | Tucks away / restores messy work |
| `gh pr create --web` | Opens PR in browser |
| `gh pr checkout <N>` | Downloads PR #N locally |
| `gh repo clone <repo>`| Clones repo by name |
