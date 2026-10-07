# 📊 Kaggle CLI for Dummies: The No-Panic Manual

> **One sentence summary:** The Kaggle CLI (`kaggle`) lets you search, download gigabytes of datasets, pull/push remote GPU notebooks (Kernels), and submit competition entries directly from your command line without touching the browser.

---

## 🔑 1-Minute Initial Setup (API Token)

Before running commands, Kaggle needs to know who you are:
1. Go to [kaggle.com/settings](https://www.kaggle.com/settings) and click **"Create New Token"**.
2. This downloads a file called `kaggle.json`.
3. Put it in `~/.kaggle/` and lock permissions:
   ```bash
   mkdir -p ~/.kaggle
   mv ~/Downloads/kaggle.json ~/.kaggle/
   chmod 600 ~/.kaggle/kaggle.json
   ```
4. Verify it works:
   ```bash
   kaggle competitions list
   ```

---

## 🛠️ Everyday Workflows

### 1. Finding & Downloading Datasets
```bash
# Search for datasets by keyword:
kaggle datasets list -s "financial sentiment"

# Download and automatically unzip into the current folder:
kaggle datasets download -d <owner>/<dataset-name> --unzip

# Download into a specific folder (e.g. ./data):
kaggle datasets download -d <owner>/<dataset-name> -p ./data --unzip
```

### 2. Working with Competitions
> ⚠️ **Important:** You must click **"Join Competition"** on the website once to accept the rules before the CLI will allow you to download competition data.

```bash
# List active competitions:
kaggle competitions list

# Download all files for a competition:
kaggle competitions download -c titanic --unzip -p ./titanic-data

# Submit your predictions file (e.g., submission.csv):
kaggle competitions submit -c titanic -f submission.csv -m "My first PyTorch baseline"

# Check your leaderboard score and submission status:
kaggle competitions submissions -c titanic
```

### 3. Running & Syncing Notebooks (Kernels)
Kaggle gives you **30 hours per week of free cloud GPUs (NVIDIA T4 / P100)**!
You can write code locally and push it to Kaggle's cloud GPUs:

```bash
# 1. Pull an existing notebook to your machine:
kaggle kernels pull <username>/<kernel-name> -p ./my-notebook

# 2. Push your updated code to run in the cloud:
kaggle kernels push -p ./my-notebook

# 3. Check the status / logs while it runs:
kaggle kernels status <username>/<kernel-name>

# 4. Download the generated output files (e.g. trained model weights):
kaggle kernels output <username>/<kernel-name> -p ./output
```

---

## 🚨 Top 3 Gotchas & Fixes

1. **`403 - Forbidden` when downloading competition data:**
   * **Fix:** You forgot to accept the rules on the website. Visit the competition URL in your browser and click "I Understand and Accept".
2. **`Could not find kaggle.json`:**
   * **Fix:** Ensure the file is at `~/.kaggle/kaggle.json` and permissions are set via `chmod 600 ~/.kaggle/kaggle.json`.
3. **Low disk space warning on your Mac:**
   * **Fix:** Always check dataset size before downloading. Large Kaggle datasets can be 50+ GB!
