# 🐘 PostgreSQL (psql) for Dummies: The No-Panic Manual

> **One sentence summary:** `psql` is the command-line interface for PostgreSQL, the world's most advanced open-source relational database, letting you run queries, manage schemas, and inspect query performance.

---

## 🧠 The 3 Golden Concepts

1. **Connection Strings / URIs**: The easiest way to connect:
   `psql "postgres://user:password@host:5432/dbname"`
2. **Backslash Meta-Commands**: `psql` uses `\` backslash commands for administrative introspection (e.g. `\l` lists databases, `\dt` lists tables).
3. **`EXPLAIN ANALYZE`**: The ultimate query optimization tool. It executes the query and prints the exact physical execution plan, index scans, and execution time in milliseconds.

---

## ⚡ The Essential `psql` Meta-Commands

```text
\l          -- List all databases
\c dbname   -- Connect to a different database
\dt         -- List all tables in current database
\d tablename-- Describe table columns, data types, and indexes
\x          -- Toggle expanded mode (displays rows vertically; lifesaver for wide tables!)
\timing     -- Toggle query execution timing in milliseconds
\q          -- Quit psql
```

---

## ⚡ The Daily 80/20 CLI One-Liners

```bash
# Connect using connection URI
psql "postgres://postgres:postgres@localhost:5432/myapp"

# Run a query from bash and exit
psql -d myapp -c "SELECT count(*) FROM users;"

# Backup database (dump)
pg_dump -Fc myapp > myapp.dump

# Restore database from backup
pg_restore -d myapp_new myapp.dump
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Forgetting the semicolon `;` in SQL statements**:
  * *Fix:* In `psql`, meta-commands starting with `\` do not need semicolons, but all SQL statements (`SELECT`, `INSERT`, `UPDATE`) MUST end with `;`.
* **Footgun: Table locks on `CREATE INDEX` in Production**:
  * *Disaster:* Running `CREATE INDEX` locks the table against all writes while building the index!
  * *Fix:* Always use `CREATE INDEX CONCURRENTLY idx_name ON table (col);`.
