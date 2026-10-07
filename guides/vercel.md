# ▲ Vercel CLI for Dummies: The No-Panic Manual

> **One sentence summary:** The Vercel CLI lets you test serverless functions locally, deploy preview environments from your terminal, and manage remote environment variables without touching the web dashboard.

---

## 🧠 The 3 Golden Concepts

1. **Preview vs Production**:
   * Running `vercel` creates a temporary preview URL (unique hash).
   * Running `vercel --prod` pushes directly to your production live domain.
2. **Environment Variable Sync**:
   * Instead of manually copying `.env` files across your team, `vercel env pull` securely downloads the remote project environment variables directly into a local `.env.local`.
3. **Local Emulation (`vercel dev`)**:
   * Emulates Vercel's edge network, middleware, and serverless functions locally on your machine.

---

## ⚡ The Daily 80/20 Commands

```bash
# Link your local directory to a Vercel project
vercel link

# Pull remote development environment variables to local .env.local
vercel env pull .env.local

# Run local development server mimicking the Vercel production edge
vercel dev

# Deploy an instant preview URL
vercel

# Deploy straight to production domain
vercel --prod
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Committing `.env.local` to Git**:
  * *Fix:* Ensure `.env*.local` is strictly listed in `.gitignore`.
* **Footgun: Unlinked Project Surprises**:
  * *Fix:* If you switch Git branches or projects, always run `vercel status` to confirm which remote project you are pointing to before deploying.
