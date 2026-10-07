# 🏎️ vLLM for Dummies: The No-Panic Manual

> **One sentence summary:** vLLM is an ultra-fast, high-throughput LLM serving engine built with PagedAttention that delivers up to 24x higher serving throughput than standard Hugging Face pipelines.

---

## 🧠 The 3 Golden Concepts

1. **PagedAttention**: Traditional attention wastes 60-80% of GPU memory on KV-cache fragmentation. PagedAttention manages memory like virtual memory pages in an OS kernel, fitting dramatically more concurrent users.
2. **Continuous Batching**: Instead of waiting for an entire batch to finish generating before starting the next prompt, new requests are dynamically inserted into iteration steps.
3. **OpenAI-Compatible Server**: Launch a production server with a single terminal command that drop-in replaces OpenAI's `api.openai.com/v1`.

---

## ⚡ The Daily 80/20 CLI Commands

```bash
# Launch high-throughput server on port 8000
vllm serve meta-llama/Llama-3.2-1B-Instruct --port 8000

# Launch with tensor parallelism across 2 or 4 GPUs
vllm serve meta-llama/Llama-3.1-70B-Instruct --tensor-parallel-size 4

# Serve using AWQ / GPTQ 4-bit quantization
vllm serve casperhansen/llama-3.2-1b-instruct-awq --quantization awq
```

---

## ⚡ Quick Python Client Request

```python
import requests

response = requests.post(
    "http://localhost:8000/v1/chat/completions",
    json={
        "model": "meta-llama/Llama-3.2-1B-Instruct",
        "messages": [{"role": "user", "content": "Tell me a joke"}]
    }
).json()

print(response["choices"][0]["message"]["content"])
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: OOM on Startup (Pre-allocating KV Cache)**:
  * *What happens:* By default, vLLM reserves 90% of your GPU VRAM (`--gpu-memory-utilization 0.90`) for the KV cache.
  * *Fix:* If you run another process or need breathing room, set `--gpu-memory-utilization 0.75`.
* **Footgun: Maximum Model Length (`max_model_len`)**:
  * *Fix:* If you get an OOM because the model's default context is 128k, cap it to realistic limits with `--max-model-len 8192`.
