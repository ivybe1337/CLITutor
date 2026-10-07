# 🤖 Gemini & Antigravity CLI for Dummies: The No-Panic Manual

> **One sentence summary:** Antigravity (`agy`) / Gemini CLI (`gemini`) is Google DeepMind's flagship pair-programming agentic CLI that combines multi-agent orchestration, native subagents, and deep tool use across your entire machine.

---

## 🧠 The Mental Model: Multi-Agent Coding Orchestration

Unlike single-turn chat bots, Antigravity functions as a lead engineer:
1. **Subagents:** It can spawn specialized subagents (researchers, testers, architects) in background threads to solve independent subtasks in parallel.
2. **Background Tasks:** Long commands (like training models, downloading datasets) run in background tasks with real-time logs while you keep working.
3. **Artifacts:** It creates structured markdown design documents, plans, and dashboards directly in your workspace.

---

## 🛠️ Everyday Workflows

### 1. Launching Antigravity / Gemini CLI
```bash
# Launch interactive session:
agy
# (or:)
gemini

# Launch with your custom quick aliases (defined in your ~/.zshrc):
gman   # Launches with yolo approval mode (auto-executes commands)
gdawg  # Launches with full experimental ACP checkpointing
```

### 2. Multi-Agent Superpowers
Inside the session, you can ask it to:
* *"Spawn a researcher agent to survey the codebase"*
* *"Run tests in the background while we write the next module"*
* *"Create an implementation plan before writing any code"*

### 3. Safety & Trash Protection
On your machine, Antigravity operates under a strict non-destructive safety contract:
* Destructive shell commands like `rm` and `rm -f` are intercepted.
* Files are safely relocated to `~/.Trash/` instead of permanent deletion.

---

## ⚡ Everyday Cheat Sheet

| Command / Flag | What It Does |
| :--- | :--- |
| `agy` / `gemini` | Starts interactive Antigravity CLI |
| `gman` | Starts with YOLO auto-approval mode |
| `gdawg` | Starts with full checkpointing & raw output |
| `/plan` | Requests a structured checklist before execution |
| `/goal` | Runs in continuous goal mode until completion |
| `/boost` | Activates deep reasoning & multi-perspective mode |
