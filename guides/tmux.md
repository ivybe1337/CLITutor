# 🪟 tmux for Dummies: The No-Panic Manual

> **One sentence summary:** `tmux` (terminal multiplexer) lets you run persistent background terminal sessions that keep executing even when you close your laptop or disconnect from an SSH server, while splitting one terminal screen into multiple tabs and panes.

---

## 🧠 The 3 Golden Concepts

1. **The Prefix Key**: tmux doesn't intercept regular keys. To send a command to tmux, you must first press the prefix: **`Ctrl-b`**, release it, and then press the action key.
2. **Session $\rightarrow$ Window $\rightarrow$ Pane Hierarchy**:
   * **Session**: The persistent container (runs forever in the background).
   * **Window**: Like a browser tab inside that session.
   * **Pane**: A split rectangular slice of a window.
3. **Attach vs Detach**:
   * **Detach** (`Ctrl-b` then `d`): Leaves your programs running in the background and returns you to your regular terminal prompt.
   * **Attach** (`tmux attach`): Reconnects your terminal directly to the running session.

---

## ⚡ The Daily 80/20 Terminal Commands

```bash
# Start a new named session
tmux new -s mydev

# List running sessions
tmux ls

# Reconnect to an existing session
tmux attach -t mydev

# Kill a session when you're completely done
tmux kill-session -t mydev
```

---

## 🎹 The Essential Hotkeys (Press `Ctrl-b`, release, then press key)

* **Panes (Splits)**:
  * `"` : Split window horizontally (top / bottom)
  * `%` : Split window vertically (left / right)
  * `Arrow Keys` : Jump focus between panes
  * `x` : Close active pane
* **Windows (Tabs)**:
  * `c` : Create new window
  * `n` / `p` : Next / Previous window
  * `0-9` : Jump directly to window number
* **Session Lifecycle**:
  * `d` : **Detach** safely (leaves everything running!)
  * `[` : Enter scroll/copy mode (use arrow keys or Vim keys to scroll history; press `q` to exit)

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Accidentally hitting `Ctrl-d` and closing the session**:
  * *Fix:* Use `Ctrl-b` then `d` to detach without terminating your running process!
* **Footgun: Nested tmux sessions over SSH**:
  * *Fix:* If you run tmux locally and tmux on a remote server, pressing `Ctrl-b` sends it to the outer tmux. Press `Ctrl-b` twice to send it to the inner remote session.
