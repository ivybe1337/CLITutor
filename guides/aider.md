# 🤖 Aider for Dummies: The No-Panic Manual

> **One sentence summary:** `aider` is an AI pair programming assistant that lives in your terminal, directly edits code across your local Git repository, and automatically commits each clean change with descriptive commit messages.

---

## 🧠 The 3 Golden Concepts

1. **In-Repo Git Awareness**: Aider builds a concise map of your entire Git codebase using AST tree-sitter symbols so the LLM understands how your modules connect without overflowing the context window.
2. **Chat Modes**:
   * `/code`: Edits your source files directly.
   * `/ask`: Answers questions and explains code without modifying any files.
   * `/architect`: Plans and reasons through multi-step refactors before touching code.
3. **Atomic Git Commits**: Every successful code modification is automatically committed to your Git history with a generated message. If you don't like an edit, type `/undo` to instantly revert the commit!

---

## ⚡ The Daily 80/20 Terminal Workflow

```bash
# Start aider using Anthropic Claude 3.5 Sonnet
aider --model sonnet

# Start aider with OpenAI or local Ollama model
aider --model deepseek/deepseek-chat
aider --model ollama/llama3.2

# Add specific files to the chat context
# Inside aider session:
/add src/main.zig
/add src/cow.zig

# Undo the last edit made by the AI
/undo

# Run terminal tests from within the session
/run pytest
/run zig build test
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Adding Too Many Files (`/add *`)**:
  * *Disaster:* Adding dozens of files burns massive token costs and confuses the LLM.
  * *Fix:* Only `/add` the 2-4 files that need direct edits; aider's repository map already provides high-level context of other files automatically.
* **Footgun: Blindly Accepting Broken Code**:
  * *Fix:* Use `/test` or `/run` immediately after each change so aider can self-correct test failures before you push to GitHub.
