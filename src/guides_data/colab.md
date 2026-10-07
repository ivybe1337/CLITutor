# 🧪 Google Colab CLI & MCP for Dummies: The No-Panic Manual

> **One sentence summary:** The Colab CLI (`colab`) and Colab MCP server (`colab-mcp`) let you spin up, control, execute code, and train models on Google's cloud NVIDIA GPUs directly from your local terminal and AI agents (Claude, Codex, Antigravity).

---

## 🧠 The Mental Model: Why Use the CLI?

Instead of opening a web browser, copying files back and forth, and clicking play buttons in a browser notebook:
* You can run Python scripts directly on a remote cloud GPU with `colab run script.py`.
* You can mount your Google Drive with one command (`colab drivemount`).
* You can SSH or open an interactive REPL directly into the remote VM (`colab ssh`).
* Your AI agents can run code directly inside a connected Colab tab via `colab-mcp`.

---

## 🛠️ Everyday Colab CLI Workflows

### 1. Check Compute Units & Active Sessions
```bash
# Check your remaining Colab compute balance:
colab usage

# List active running sessions:
colab sessions

# Check details of the current active session:
colab status
```

### 2. Run a Script on a Fresh Cloud GPU and Auto-Release
Don't waste compute units leaving instances running overnight. `colab run` spins up a VM, executes your script, streams logs to your terminal, and terminates the VM when finished:
```bash
colab run train_model.py
```

### 3. Interactive REPL & Remote Shell
```bash
# Open an interactive Python prompt running directly on the Colab VM:
colab repl

# SSH directly into the remote Colab Linux container:
colab ssh
```

### 4. Execute Quick Commands or Install Packages Remotely
```bash
# Check remote GPU name:
colab exec "import torch; print(torch.cuda.get_device_name(0))"

# Install Python packages on the remote VM:
colab install "transformers" "datasets" "accelerate"

# List files on the remote VM:
colab ls
```

### 5. Transferring Files & Google Drive
```bash
# Mount Google Drive on the remote VM:
colab drivemount

# Upload a local file to the Colab VM:
colab upload ./dataset.csv

# Download a file from the Colab VM to your Mac:
colab download ./checkpoint.pth
```

### 6. Clean Up & Stop (Save Your Compute Units!)
Always stop your instance when you are done to avoid burning paid units:
```bash
colab stop
```

---

## 🤖 Colab MCP in Claude & Codex

Your system has `colab-mcp` installed at `/Users/joshua/.local/bin/colab-mcp`.

* **How it works:** When Claude or Codex wants to interact with your notebook, it calls the `open_colab_browser_connection` tool.
* It pops open a Colab tab in your browser with a secure token, linking your AI agent directly to the notebook cells.
* You can ask your agent: *"Run this PyTorch training loop inside my Colab session"* and it drives the execution remotely.

---

## ⚡ Everyday Cheat Sheet

| Command | What It Does |
| :--- | :--- |
| `colab usage` | Shows remaining compute units |
| `colab sessions` | Lists all active VMs |
| `colab new` | Starts a new VM session |
| `colab run <script.py>`| Runs script on fresh VM, then releases VM |
| `colab exec "<code>"` | Runs one-line Python code on remote VM |
| `colab install <pkg>` | Installs pip packages on remote VM |
| `colab ssh` | Connects via SSH to remote VM |
| `colab repl` | Starts interactive Python prompt on remote VM |
| `colab upload <file>` | Uploads local file to remote VM |
| `colab download <file>`| Downloads file from remote VM |
| `colab drivemount` | Mounts Google Drive at `/content/drive` |
| `colab stop` | Shuts down session to save compute units |
