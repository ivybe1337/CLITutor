# ⚡ Modal for Dummies: The No-Panic Manual

> **One sentence summary:** Modal (`modal`) is serverless cloud computing for Python that lets you run any function on NVIDIA cloud GPUs (T4, A10G, A100, H100) with 2-second cold starts and per-second billing.

---

## 🧠 The Mental Model: Cloud GPUs from Your Local Script

Instead of renting an AWS EC2 instance, configuring CUDA drivers, SSHing in, and forgetting to shut it down:
1. You decorate a standard Python function with `@app.function(gpu="T4")`.
2. You run `modal run my_script.py` from your Mac.
3. Modal packages your code, spins up a GPU container in the cloud, runs your function, streams print statements back to your terminal, and kills the container the microsecond it finishes.

---

## 🔑 Initial Setup
```bash
# Authenticate your machine with Modal:
modal setup
```

---

## 🛠️ Minimal Working Example

Create `run_gpu.py`:
```python
import modal

app = modal.App("dummy-gpu-test")

# Define the container image with PyTorch:
image = modal.Image.debian_slim().pip_install("torch")

@app.function(image=image, gpu="T4", timeout=120)
def compute_on_cloud_gpu():
    import torch
    gpu_name = torch.cuda.get_device_name(0)
    print(f"🚀 Hello from Modal GPU: {gpu_name}")
    # Run heavy matrix math here
    x = torch.randn(5000, 5000, device="cuda")
    return (x @ x).mean().item()

@app.local_entrypoint()
def main():
    print("Calling cloud function...")
    result = compute_on_cloud_gpu.remote()
    print(f"✅ Result from cloud: {result}")
```

Run it directly from your terminal:
```bash
modal run run_gpu.py
```

---

## 🛠️ Everyday Workflows

### 1. Persistent Storage (Volumes)
Cloud containers are temporary. If you download a 10 GB model weight, store it in a Modal Volume so you don't redownload it on every run:
```bash
# Create a shared volume:
modal volume create model-weights

# List files in the volume:
modal volume ls model-weights

# Upload weights to volume:
modal volume put model-weights ./my-model.pth /my-model.pth
```

### 2. Secrets (API Keys)
Never hardcode HuggingFace or OpenAI keys in code:
```bash
# Create a secret in Modal:
modal secret create huggingface-secret HF_TOKEN=hf_abc123...
```
In your Python script:
```python
@app.function(secrets=[modal.Secret.from_name("huggingface-secret")])
```

### 3. Deploying (Persistent Web Endpoints or Cron Jobs)
```bash
# Deploy an app permanently:
modal deploy app.py

# List active deployed apps:
modal app list

# Stop an app immediately (stop spending money):
modal app stop <app-id>
```

---

## 🚨 Top 3 Safety Rules for Modal

1. **Always set `timeout` on `@app.function`:**
   * e.g., `@app.function(gpu="A100", timeout=300)`
   * If your script hits an infinite loop or stalls on downloading data, Modal automatically shuts it down after 5 minutes so you don't get a surprise bill!
2. **Choose the right GPU for the job:**
   * `gpu="T4"` (~$0.59/hr): Great for basic inference, small fine-tunes, embeddings.
   * `gpu="A10G"` (~$1.10/hr): Great for 7B–14B LLMs and Stable Diffusion.
   * `gpu="A100-40GB"` (~$3.67/hr): For heavy LLM training or 70B inference.
3. **Check your dashboard:**
   * Go to `modal.com/apps` anytime to see real-time GPU activity and logs.
