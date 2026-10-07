# 🦙 llama.cpp for Dummies: The No-Panic Manual

> **One sentence summary:** `llama.cpp` is a lightning-fast C/C++ engine that lets you run modern Large Language Models (LLMs like Llama 3, Mistral, Qwen, DeepSeek) locally on your Mac using Apple Silicon Metal acceleration and `.gguf` model files.

---

## 🧠 The 3 Concepts You Need to Know

1. **`.gguf` File Format:** A single, self-contained binary file containing the model's weights and architecture. No Python or complex dependencies required to load it.
2. **Quantization (Q4_K_M, Q8_0):** Compressing model weights so they fit into your Mac's RAM without losing intelligence:
   * **`Q4_K_M` (4-bit):** The sweet spot. Cuts RAM usage by ~70% while keeping ~98% of the original model's quality.
   * **`Q8_0` (8-bit):** Near-lossless, requires roughly double the RAM of 4-bit.
   * **Rule of thumb:** An 8B model in Q4_K_M needs ~5.5 GB RAM. A 14B model needs ~9.5 GB RAM.
3. **`-ngl 99` (Number of GPU Layers):**
   * The most important flag!
   * Telling `llama.cpp` `-ngl 99` offloads **all layers** directly to your Apple Silicon Metal GPU. If you forget this flag, it runs slowly on your CPU.

---

## 🛠️ Everyday Workflows

### 1. Interactive Chat with Any Model Directly from HuggingFace
You don't even need to download the model file first! `llama.cpp` can stream and cache it directly from Hugging Face:

```bash
# Chat with Qwen 2.5 (3B) using Mac GPU:
llama-cli -hf Qwen/Qwen2.5-3B-Instruct-GGUF -ngl 99 -c 4096 -cnv

# Chat with Llama 3.2 (3B):
llama-cli -hf bartowski/Llama-3.2-3B-Instruct-GGUF:Q4_K_M -ngl 99 -c 4096 -cnv
```
*(The `-cnv` flag puts you in continuous interactive conversation mode).*

### 2. Running a Local OpenAI-Compatible Server
Start a background API server that any tool, script, or web UI (like OpenWebUI or cursor) can talk to:

```bash
# Start the server on port 8080:
llama-server -hf Qwen/Qwen2.5-7B-Instruct-GGUF:Q4_K_M -ngl 99 -c 8192 --port 8080
```

Now you can test it with `curl` or any OpenAI SDK:
```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [{"role": "user", "content": "Explain quantum computing in one sentence."}]
  }'
```

### 3. Running a Locally Downloaded `.gguf` File
```bash
# If you downloaded a .gguf file to ~/Downloads/model.gguf:
llama-cli -m ~/Downloads/model.gguf -ngl 99 -c 4096 -p "Write a poem about space:"
```

### 4. Benchmarking Your Mac's Speed
Find out how many tokens per second your Mac can generate:
```bash
llama-bench -hf Qwen/Qwen2.5-3B-Instruct-GGUF:Q4_K_M -ngl 99
```

---

## ⚡ The Essential Flag Cheat Sheet

| Flag | Meaning | Best Setting |
| :--- | :--- | :--- |
| `-ngl <N>` | Number of GPU Layers to offload | `-ngl 99` (offload everything to Metal GPU) |
| `-c <N>` | Context Window Size (token memory) | `-c 4096` or `-c 8192` |
| `-cnv` | Interactive chat / conversation mode | Use for chatting in terminal |
| `-t <N>` | CPU threads to use | Number of high-performance cores (e.g. `-t 6`) |
| `-temp <F>`| Creativity / randomness | `-temp 0.7` for chat, `-temp 0.2` for coding/facts |
| `--port <N>`| Port for `llama-server` | `--port 8080` |
| `-m <path>`| Path to local `.gguf` file | `-m ./my-model.gguf` |
| `-hf <repo>`| Load directly from HuggingFace repo | `-hf username/repo:filename` |

---

## 🚨 Top 3 Gotchas & Fixes

1. **Generation is super slow (2-5 tokens/sec):**
   * **Fix:** You forgot `-ngl 99`! Without it, your Mac's Metal GPU isn't being used.
2. **Mac freezes or process gets killed:**
   * **Cause:** The model + context window is bigger than your physical RAM.
   * **Fix:** Use a smaller quantization (e.g. `Q4_K_M` instead of `Q8_0`) or a smaller model size (3B or 7B instead of 70B).
3. **Where are HuggingFace models cached?**
   * `llama.cpp` stores downloaded models in `~/Library/Caches/llama.cpp/`.
