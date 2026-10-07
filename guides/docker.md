# 🐳 Docker for Dummies: The No-Panic Manual

> **One sentence summary:** Docker packages your application code, dependencies, and OS libraries into a lightweight, portable container so that "it works on my machine" becomes "it works everywhere."

---

## 🧠 The 3 Golden Concepts

1. **Image vs Container**:
   * **Image**: The immutable blueprint (like a class or a recipe). Read-only snapshot of your file system and setup.
   * **Container**: A running instance of an image (like an object or a baked cake). Has its own isolated network, process tree, and temporary filesystem.
2. **Volume**: By default, data inside a container **dies when the container stops**. Volumes attach a real folder on your host machine to keep data alive across restarts (e.g. database storage).
3. **Port Mapping (`-p host:container`)**: Containers run in their own private network. `-p 8080:80` maps port `8080` on your laptop to port `80` inside the container.

---

## ⚡ The Daily 80/20 Commands

```bash
# Run an image interactively and throw it away on exit
docker run --rm -it -p 8000:8000 -v $(pwd):/app python:3.11-slim bash

# Build an image from a Dockerfile in the current directory
docker build -t myapp:latest .

# List running containers (add -a to see stopped ones too)
docker ps -a

# View real-time logs with follow
docker logs -f <container_name_or_id>

# Jump inside an already running container
docker exec -it <container_name_or_id> /bin/bash

# Stop and kill containers
docker stop <container_id>
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Huge Images (Gigabytes of junk)**:
  * *Fix:* Use slim base images (`python:3.11-slim`, `node:alpine`) and always add a `.dockerignore` file containing `.git`, `node_modules`, `__pycache__`, and `.venv`.
* **Footgun: Disk Filling Up with Abandoned Containers**:
  * *Fix:* Run `docker system prune -a --volumes` to instantly reclaim dozens of gigabytes of orphaned build layers and dangling volumes.
* **Footgun: Port Already In Use**:
  * *Fix:* If `Bind for 0.0.0.0:5432 failed: port is already allocated`, run `clit lsof -i :5432` to find the process hogging the port.

---

## 📋 Docker Compose One-Liner

When you have a web app + PostgreSQL + Redis, don't run 3 docker commands:
```bash
docker compose up -d       # Start all services in the background
docker compose logs -f      # Watch aggregated logs
docker compose down         # Stop and clean up containers and networks
```
