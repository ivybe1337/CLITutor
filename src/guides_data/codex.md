# 🤖 OpenAI Codex CLI for Dummies: The No-Panic Manual

> **One sentence summary:** Codex (`codex`) is OpenAI's terminal-based autonomous coding agent that inspects codebases, executes shell commands, runs tests, and debugs code with deep reasoning.

---

## 🧠 The Mental Model: Autonomous Coding Agent

Codex connects directly to advanced OpenAI reasoning models (like `gpt-5.5` or `gpt-6-astra`):
* It has full terminal tool access (can run compilers, git, curl, test suites).
* It can work in background threads while you do other things.
* Its configuration lives in `~/.codex/config.toml`.

---

## 🛠️ Everyday Workflows

### 1. Launching Codex
```bash
# Start an interactive TUI session in your current directory:
codex

# Launch with a specific instruction:
codex "Refactor the database queries in src/db.ts to use connection pooling"
```

### 2. Controlling Reasoning Effort & Models
For simple typos you want fast responses; for complex math or architectural refactors you want high reasoning effort:
```bash
# Dial up reasoning effort for complex bugs:
codex --reasoning-effort high "Trace race condition in worker.zig"

# Select a specific model:
codex --model gpt-5.5
```

### 3. Checking Active MCP Servers
Codex integrates with your local MCP tools (like `colab`, `playwright`, `latticevault`):
```bash
# List all configured MCP servers and their status:
codex mcp list
```

### 4. Updating Codex via Bun
On your machine, Codex is managed globally by Bun:
```bash
# Update Codex to latest version:
bun add -g @openai/codex@latest
```

---

## ⚡ Everyday Cheat Sheet

| Command / Flag | What It Does |
| :--- | :--- |
| `codex` | Launches interactive coding agent session |
| `codex "prompt"` | Launches directly with task |
| `--reasoning-effort <low\|med\|high>` | Adjusts depth of agent thought |
| `codex mcp list` | Inspects connected MCP servers |
| `~/.codex/config.toml` | Central config (models, trust, keys, MCP) |
| `Ctrl+C` | Aborts current agent generation |
| `Ctrl+D` (or `exit`) | Quits session safely |
