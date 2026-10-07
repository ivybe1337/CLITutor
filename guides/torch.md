# 🔥 PyTorch for Dummies: The No-Panic Manual

> **One sentence summary:** PyTorch is the world's most popular AI framework; it lets you do high-speed math on multi-dimensional grids of numbers called **Tensors** and runs them on your GPU (Metal on Mac, CUDA in Cloud).

---

## 🧠 The 3 Golden Concepts

1. **Tensor**: Just a fancy NumPy array that can live on your GPU.
2. **Device**: Where the tensor physically lives:
   * `cpu`: Slow, uses normal system RAM.
   * `mps`: **Apple Silicon Mac GPU** (M1/M2/M3/M4 Metal Performance Shaders). Lightning fast on Mac!
   * `cuda`: **NVIDIA GPU** in the cloud (Modal, Colab, AWS).
3. **Autograd**: PyTorch automatically tracks math operations so it can calculate gradients (derivatives) for neural network training with `.backward()`.

---

## ⚡ The Universal Device One-Liner

Always start every PyTorch script with this so it runs automatically on your Mac **or** in the cloud:

```python
import torch

device = torch.device(
    "cuda" if torch.cuda.is_available() 
    else "mps" if torch.backends.mps.is_available() 
    else "cpu"
)
print(f"🚀 Running on: {device}")
```

---

## 🛠️ Everyday PyTorch Workflows

### 1. Verification: Is PyTorch Seeing Your Mac GPU?
Run this one-liner in your terminal:
```bash
python -c "import torch; print('Torch:', torch.__version__, '| Mac GPU (MPS) Available:', torch.backends.mps.is_available())"
```

### 2. Tensors 101: Creating and Moving to GPU
```python
import torch

# Create a tensor on CPU
x = torch.tensor([[1.0, 2.0], [3.0, 4.0]])

# Move it to your GPU (MPS or CUDA)
x_gpu = x.to(device)

# Fast math happens on GPU
y_gpu = x_gpu @ x_gpu  # Matrix multiplication

# Move back to CPU / NumPy when you want to print or plot
y_cpu = y_gpu.cpu().numpy()
```

### 3. Training Loop: The Universal 5 Steps
Every neural network training loop follows this exact sequence:
```python
import torch
import torch.nn as nn

# 1. Define model & move to GPU
model = nn.Sequential(
    nn.Linear(10, 64),
    nn.ReLU(),
    nn.Linear(64, 1)
).to(device)

optimizer = torch.optim.Adam(model.parameters(), lr=0.001)
criterion = nn.MSELoss()

# Dummy data
inputs = torch.randn(32, 10).to(device)
targets = torch.randn(32, 1).to(device)

# The 5-Step Training Loop:
for epoch in range(10):
    # Step 1: Forward pass (make prediction)
    outputs = model(inputs)
    loss = criterion(outputs, targets)

    # Step 2: Zero old gradients
    optimizer.zero_grad()

    # Step 3: Backward pass (compute gradients)
    loss.backward()

    # Step 4: Update weights
    optimizer.step()

    print(f"Epoch {epoch}: Loss = {loss.item():.4f}")
```

### 4. Inference Mode (Saving RAM & Speeding Up)
When running predictions with a trained model, **always** use `torch.inference_mode()` (replaces `torch.no_grad()`):
```python
model.eval()
with torch.inference_mode():
    prediction = model(inputs)
```

### 5. Saving and Loading Weights Safely
```python
# Save weights to disk:
torch.save(model.state_dict(), "model.pth")

# Load weights back:
model.load_state_dict(torch.load("model.pth", weights_only=True))
```

---

## 💾 Mac Memory & Disk Hygiene

1. **Freeing GPU memory:**
   Mac Unified Memory is shared between CPU and GPU. If PyTorch holds memory:
   ```python
   # On Mac:
   torch.mps.empty_cache()
   # On Cloud CUDA:
   torch.cuda.empty_cache()
   ```
2. **Float Precision:**
   * Default is `torch.float32` (high memory).
   * For large models (LLMs/vision), use `torch.float16` or `torch.bfloat16` to cut memory usage in half:
     ```python
     x = torch.randn(1000, 1000, dtype=torch.bfloat16).to(device)
     ```

---

## 🚨 Top 3 Gotchas & Fixes

1. **`RuntimeError: Expected all tensors to be on the same device`**
   * **Cause:** You tried to add or multiply a CPU tensor with a GPU tensor.
   * **Fix:** Make sure both tensors have `.to(device)`.
2. **`RuntimeError: MPS backend out of memory`**
   * **Cause:** Batch size is too big or you aren't clearing cache.
   * **Fix:** Lower batch size (e.g. from 64 to 16) and wrap evaluation in `torch.inference_mode()`.
3. **Disk space bloat:**
   * With `uv`, wheels are cached once in `~/.cache/uv`. Multiple projects clone the files with 0 extra disk usage on APFS.
