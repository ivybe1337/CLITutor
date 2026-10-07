# 🍞 Bun & TypeScript for Dummies: The No-Panic Manual

> **One sentence summary:** `bun` is an all-in-one replacement for `node`, `npm`, `npx`, `pnpm`, and `tsc` (TypeScript compiler) written in Zig that runs code and installs packages at blinding speeds.

---

## 🥊 Bun vs. npm vs. pnpm: What's the Difference?

```
┌────────────────────────────────────────────────────────────────────────┐
│                        THE JAVASCRIPT ECOSYSTEM                        │
├──────────────────┬─────────────────┬──────────────────┬────────────────┤
│ Feature          │ npm (Old School)│ pnpm (Efficient) │ Bun (The Beast)│
├──────────────────┼─────────────────┼──────────────────┼────────────────┤
│ Runtime Engine   │ Node.js (V8)    │ Node.js (V8)     │ JavaScriptCore │
│ Package Manager  │ Slow, bloated   │ Fast, symlinked  │ 10x-30x faster │
│ Runs TypeScript? │ ❌ Needs build  │ ❌ Needs build   │ ✅ Out of box  │
│ Runs JSX / TSX?  │ ❌ Needs Babel  │ ❌ Needs Babel   │ ✅ Native      │
│ Loads .env files │ ❌ Needs dotenv │ ❌ Needs dotenv  │ ✅ Automatic   │
│ Built-in SQLite  │ ❌ Needs addon  │ ❌ Needs addon   │ ✅ Built-in    │
└──────────────────┴─────────────────┴──────────────────┴────────────────┘
```

### Why Bun Won on Your System:
1. **Zero-Compile TypeScript:** In standard Node, you had to compile `.ts` files with `tsc`, configure `tsconfig.json`, or install heavy wrappers like `ts-node` or `tsx`. With Bun, you just run:
   ```bash
   bun run script.ts
   ```
   Bun parses and executes TypeScript natively with zero delay.
2. **Speed:** `bun install` takes milliseconds where `npm install` takes 30–60 seconds.
3. **No Masquerading:** On your machine, `bun` handles JS/TS, while standard Python handles ML.

---

## 🛠️ Everyday Workflows

### 1. Running Scripts & TypeScript Directly
```bash
# Run any JavaScript or TypeScript file directly
bun run index.ts
# Or shorthand:
bun index.ts

# Execute a one-liner directly in terminal:
bun -e "console.log('Bun is ready:', Bun.version)"

# Watch mode (automatically re-runs when you save changes):
bun --watch index.ts
```

### 2. Creating a New Project
```bash
# 1. Create a directory and jump in
mkdir my-ts-app && cd my-ts-app

# 2. Initialize a new Bun project (creates package.json, tsconfig.json, index.ts)
bun init

# 3. Run it
bun run index.ts
```

### 3. Managing Packages (Install, Update, Remove)
```bash
# Install a package into your project:
bun add hono zod

# Install a development dependency (like type definitions):
bun add -d @types/node

# Install an exact version:
bun add express@4.18.2

# Remove a package:
bun remove express
# (or shorthand:)
bun rm express

# Reinstall all project packages from package.json:
bun install
```

### 4. Global Packages (CLI Tools like Claude Code)
```bash
# Install a CLI tool globally:
bun add -g @anthropic-ai/claude-code@latest

# List globally installed packages:
bun list -g

# Remove a globally installed package:
bun rm -g <package-name>
```

### 5. Running Scripts from `package.json`
If your `package.json` has:
```json
"scripts": {
  "dev": "bun run --watch src/index.ts",
  "build": "bun build src/index.ts --outdir ./dist"
}
```
You simply run:
```bash
bun run dev
bun run build
```

### 6. Bundling & Compiling (Single Executable or Dist Folder)
Bun can bundle your entire TypeScript app into a standalone file or directory:
```bash
# Bundle into a single output file:
bun build ./src/index.ts --outdir ./dist --target bun

# Compile your TypeScript app into a standalone binary executable:
bun build ./src/index.ts --compile --outfile myapp
./myapp
```

---

## ⚡ Everyday Cheat Sheet

| Command | What It Does (npm equivalent) |
| :--- | :--- |
| `bun <file.ts>` | Runs TypeScript file directly (no compile step!) |
| `bun --watch <file.ts>` | Hot-reloading development runner |
| `bun add <pkg>` | `npm install <pkg>` (installs dependency) |
| `bun add -d <pkg>` | `npm install -D <pkg>` (installs dev dependency) |
| `bun rm <pkg>` | `npm uninstall <pkg>` (removes dependency) |
| `bun install` | `npm install` (restores from package.json) |
| `bun add -g <pkg>` | `npm install -g <pkg>` (global CLI install) |
| `bun rm -g <pkg>` | `npm uninstall -g <pkg>` (global CLI remove) |
| `bun list -g` | `npm list -g --depth=0` (list global tools) |
| `bun x <tool>` | `npx <tool>` (execute temporary package) |
| `bun test` | Runs tests using built-in Jest/Vitest compatible runner |
| `bun pm cache rm` | Clears Bun package cache |
