# 🦕 Deno for Dummies: The No-Panic Manual

> **One sentence summary:** `Deno` is a modern, secure-by-default runtime for TypeScript and JavaScript created by Ryan Dahl (the original creator of Node.js), featuring zero-config TypeScript execution, built-in tooling, and web-standard APIs.

---

## 🧠 The 3 Golden Concepts

1. **Security by Default**: Unlike Node.js where any script can read your SSH keys and hard drive, Deno blocks file, network, and environment access unless you grant explicit permission flags (`--allow-net`, `--allow-read`).
2. **First-Class TypeScript**: No `tsconfig.json`, no `tsc`, no `ts-node`. Deno executes `.ts` files directly.
3. **Batteries Included**: Deno has built-in testing (`deno test`), linting (`deno lint`), and formatting (`deno fmt`) out of the box.

---

## ⚡ The Daily 80/20 Commands

```bash
# Run a TypeScript file with network permissions
deno run --allow-net server.ts

# Run giving all permissions (like traditional Node.js)
deno run -A app.ts

# Format and lint your entire repository
deno fmt
deno lint

# Run built-in test runner
deno test

# Compile a TypeScript script into a single standalone executable binary!
deno compile --allow-net -o mytool cli.ts
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Permission Denied at Runtime**:
  * *Error:* `PermissionDenied: Requires net access to "api.github.com"`.
  * *Fix:* Add the required flag (e.g. `--allow-net=api.github.com` or `-A` for all permissions during rapid local development).
