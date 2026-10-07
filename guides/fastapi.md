# ⚡ FastAPI for Dummies: The No-Panic Manual

> **One sentence summary:** FastAPI is a modern, high-performance Python web framework that automatically validates request data using Pydantic, generates interactive Swagger OpenAPI documentation, and runs with native `async/await` speed.

---

## 🧠 The 3 Golden Concepts

1. **Automatic Data Validation (Pydantic)**: Define a class with type hints (`class Item(BaseModel): name: str, price: float`); FastAPI validates incoming JSON bodies and returns clear 422 errors automatically.
2. **Automatic Interactive Docs**: Navigate to `http://localhost:8000/docs` in your browser to test endpoints interactively with Swagger UI.
3. **Dependency Injection (`Depends`)**: Cleanly inject database sessions, authentication checks, and shared logic into endpoint functions.

---

## ⚡ The 8-Line Starter Server (`main.py`)

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    username: str
    email: str

@app.post("/users")
async def create_user(user: User):
    return {"message": f"User {user.username} created!"}
```

---

## ⚡ The Daily 80/20 CLI Commands

```bash
# Run server with live hot-reloading on port 8000
fastapi dev main.py

# Or using uvicorn directly
uvicorn main:app --reload --port 8000

# Production run with multiple workers
fastapi run main.py --workers 4
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Blocking synchronous code inside `async def`**:
  * *Disaster:* Calling `time.sleep(5)` or synchronous `requests.get(...)` inside an `async def` endpoint blocks the entire Python event loop for all users!
  * *Fix:* Use `httpx.AsyncClient` or define standard `def` (without `async`)—FastAPI will automatically run it in a threadpool without blocking the server!
