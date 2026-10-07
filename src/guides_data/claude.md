# 🤖 Claude Code for Dummies: The No-Panic Manual

> **One sentence summary:** Claude Code (`claude`) is Anthropic's official terminal agent that lives directly inside your codebase; it can read files, write code, run terminal commands, fix bugs, and create Git commits autonomously.

---

## 🧠 The Mental Model: Pair Programming with an AI in Your Shell

Unlike copy-pasting code into ChatGPT in a browser:
1. You run `claude` inside any project folder.
2. Claude explores your directory, reads your code, and plans changes.
3. Before running terminal commands or modifying files, it shows you a diff and asks for approval (or runs automatically with permissions).
4. It remembers your project conventions via `CLAUDE.md`.

---

## 🛠️ Everyday Workflows

### 1. Starting a Session
```bash
# Enter your project directory:
cd ~/my-project

# Launch Claude Code:
claude

# Or launch with an initial instruction:
claude "Find and fix the memory leak in src/server.py"
```

### 2. The 5 Essential Slash Commands Inside the Chat
Once inside `claude`, use these slash commands:
* `/help` — Lists all available commands.
* `/compact` — Compresses conversation memory to free context space without forgetting key decisions.
* `/clear` — Clears conversation history to start fresh on a new task.
* `/cost` — Shows token usage and cost for the current session.
* `/exit` (or `Ctrl+D`) — Exits back to your shell safely.

### 3. Single-Shot Mode (From Your Terminal)
You don't always have to open an interactive chat session:
```bash
# Run a quick task non-interactively:
claude -p "Explain what this repository does in 3 bullet points"
```

### 4. Managing MCP Servers (Extending Claude's Tools)
Claude Code connects to Model Context Protocol (MCP) servers (like `colab-mcp` or `playwright`):
```bash
# List all connected MCP servers:
claude mcp list

# Add a new MCP server:
claude mcp add my-tool /path/to/binary
```

---

## 💡 The `CLAUDE.md` Cheat Code

Claude automatically reads a file named `CLAUDE.md` in the root of your project. Put your project's rules there so you never have to repeat yourself:
```markdown
# Project Rules
- Always use `bun` instead of `npm`.
- Tests run with `bun test`.
- All Python commands must use `uv run`.
```

---

## ⚡ Everyday Cheat Sheet

| Command / Flag | What It Does |
| :--- | :--- |
| `claude` | Starts interactive agent session in current folder |
| `claude "prompt"` | Starts session with immediate task |
| `claude -p "prompt"` | Headless single-shot execution |
| `/compact` | Compresses session memory |
| `/clear` | Starts a clean task context |
| `claude mcp list` | Shows active MCP tools |
| `CLAUDE.md` | Local memory file with your project rules |
