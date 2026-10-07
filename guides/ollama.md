# 🦙 Ollama for Dummies: The No-Panic Manual

> **One sentence summary:** Ollama is Docker for local LLMs—it lets you download and run models like Llama 3, Mistral, and DeepSeek locally with a single command, automatically managing GPU acceleration and exposing a local REST API.

---

## 🧠 The 3 Golden Concepts

1. **One-Command Inference**: Running `ollama run <model>` downloads the model weights, loads them into your GPU memory (Metal on Apple Silicon, CUDA on Nvidia), and opens an interactive chat terminal.
2. **OpenAI-Compatible Local API**: Ollama automatically runs a background server at `http://localhost:11434/v1`. Any tool or script that supports OpenAI can be pointed at Ollama for 100% free, private local inference.
3. **Modelfile**: A plain text configuration file (like a Dockerfile) where you can customize system prompts, temperature, and context length.

---

## ⚡ The Daily 80/20 Commands

```bash
# Pull and chat with a model interactively
ollama run llama3.2

# List all downloaded models taking up local space
ollama list

# Check which model is currently loaded in GPU RAM
ollama ps

# Remove a model to free disk space
ollama rm mistral

# Stop running background server / unload model from GPU
ollama stop llama3.2
```

---

## ⚡ Pointing OpenAI Python Scripts to Ollama

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama" # Required by client, but ignored by Ollama
)

response = client.chat.completions.create(
    model="llama3.2",
    messages=[{"role": "user", "content": "Hello local LLM!"}]
)
print(response.choices[0].message.content)
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Ollama Hogging GPU RAM in Background**:
  * *What happens:* Ollama keeps the model loaded in GPU RAM for 5 minutes after your last prompt so the next request is instant.
  * *Fix:* Run `ollama stop <model>` to immediately unload it and free up your GPU memory for other workloads.
* **Footgun: Running Models Too Big for Your VRAM**:
  * *Rule of Thumb:* 
    * 7B/8B model in 4-bit (q4) requires ~5.5 GB VRAM.
    * 14B model requires ~10 GB VRAM.
    * 70B model requires ~40 GB VRAM.
