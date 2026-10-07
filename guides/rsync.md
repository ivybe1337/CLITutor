# 🔄 rsync for Dummies: The No-Panic Manual

> **One sentence summary:** `rsync` (remote sync) is a blazingly fast file copying tool that only transfers the byte differences (deltas) between source and destination, locally or over SSH.

---

## 🧠 The 3 Golden Concepts

1. **The Delta-Transfer Algorithm**: If a 10 GB file has only 1 MB of changes, `rsync` only sends that 1 MB instead of copying the whole 10 GB again.
2. **The Trailing Slash Rule (`src/` vs `src`)**:
   * `rsync -a src/ dest/`: Copies the **contents** of `src/` directly inside `dest/`.
   * `rsync -a src dest/`: Copies the **folder itself**, resulting in `dest/src/`.
3. **Archive Mode (`-a`)**: Preserves file permissions, timestamps, symbolic links, and recurses directories safely.

---

## ⚡ The Gold-Standard Command: `-avzP`

Remember this 5-letter flag combination forever:
* **`-a`** : Archive mode (recursive, preserves permissions/timestamps).
* **`-v`** : Verbose (shows which files are copied).
* **`-z`** : Compress data during transfer.
* **`-P`** : Shows live progress bar and allows resuming broken transfers!

```bash
# Local directory backup
rsync -avzP src/ /backup/src/

# Sync to a remote server over SSH
rsync -avzP ./build/ ubuntu@myserver.com:/var/www/html/

# Mirror directories exactly (deletes destination files that don't exist in source)
rsync -avzP --delete ./local/ ./remote/

# Dry-run preview: SEE what will be copied without touching disk!
rsync -avzP --dry-run ./local/ ./remote/
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Accidentally wiping files with `--delete`**:
  * *Disaster:* If you mix up source and destination, `--delete` will delete your entire project!
  * *Fix:* ALWAYS run with `--dry-run` first to preview the changes.
