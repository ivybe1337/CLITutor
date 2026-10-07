# 📦 pnpm for Dummies: The No-Panic Manual

> **One sentence summary:** `pnpm` (performant npm) is a disk-efficient, high-speed JavaScript package manager that saves gigabytes of disk space by storing all downloaded packages in a single global content-addressable store and hard-linking them into projects.

---

## 🧠 The 3 Golden Concepts

1. **Hard Links & The Global Store**: Unlike `npm` which copies 500 MB of `node_modules` into every single project on your laptop, `pnpm` keeps 1 copy on disk and creates hard links to it.
2. **Strict `node_modules`**: Prevents phantom dependencies (you can't import a package your app depends on unless you explicitly declared it in `package.json`).
3. **Workspaces**: Native, first-class support for monorepos with `pnpm-workspace.yaml`.

---

## ⚡ The Daily 80/20 Commands

```bash
# Install dependencies for project
pnpm install

# Add a package to dependencies
pnpm add react react-dom

# Add a dev dependency
pnpm add -D typescript vitest

# Run scripts from package.json
pnpm dev
pnpm build
pnpm test

# Run a one-off binary without installing (replaces npx)
pnpm dlx create-next-app@latest
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Phantom Dependency Crashes**:
  * *Confusion:* Code worked in `npm` but fails in `pnpm` with `Cannot find module 'foo'`.
  * *Reason:* `npm` hoists all transitive dependencies to top-level `node_modules`. `pnpm` strictly isolates them.
  * *Fix:* Run `pnpm add foo` to explicitly declare your dependency.
