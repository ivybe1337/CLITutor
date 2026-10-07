# ⚡ OpenAI Triton for Dummies: The No-Panic Manual

> **One sentence summary:** Triton is a programming language and compiler from OpenAI that lets you write blazing-fast custom GPU kernels directly in Python instead of having to write complex C++ and CUDA.

---

## 🧠 The 3 Golden Concepts

1. **Blocks Instead of Threads**: In CUDA, you manage individual threads. In Triton, you operate on **Blocks of vectors/tensors** (e.g. 128 or 256 numbers at a time), and the compiler automatically optimizes memory layouts and thread warps.
2. **Pointers & Offsets**: Triton kernels compute pointer arithmetic: `ptrs = base_ptr + offsets`.
3. **The JIT Decorator (`@triton.jit`)**: Mark your Python function with `@triton.jit`. Triton compiles it into native Nvidia PTX or AMD GPU machine code on the fly.

---

## ⚡ The Minimal Triton Vector Addition Kernel

```python
import torch
import triton
import triton.language as tl

@triton.jit
def add_kernel(x_ptr, y_ptr, output_ptr, n_elements, BLOCK_SIZE: tl.constexpr):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE
    offsets = block_start + tl.arange(0, BLOCK_SIZE)
    mask = offsets < n_elements
    x = tl.load(x_ptr + offsets, mask=mask)
    y = tl.load(y_ptr + offsets, mask=mask)
    tl.store(output_ptr + offsets, x + y, mask=mask)

def add(x: torch.Tensor, y: torch.Tensor):
    output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']),)
    add_kernel[grid](x, y, output, n_elements, BLOCK_SIZE=1024)
    return output
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Power-of-Two Block Sizes**:
  * *Rule:* `BLOCK_SIZE` in Triton **must** be a power of two (64, 128, 256, 512, 1024).
* **Footgun: Forgetting Masks on Boundary Elements**:
  * *Fix:* Always provide `mask=offsets < n_elements` when loading and storing memory; otherwise, you will read/write out of bounds and trigger a GPU segfault (`cudaErrorIllegalAddress`).
