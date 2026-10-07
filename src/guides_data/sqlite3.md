# 💾 SQLite (sqlite3) for Dummies: The No-Panic Manual

> **One sentence summary:** SQLite is the world's most deployed SQL database engine—an ultra-reliable, zero-configuration database that lives entirely in a single file on your disk.

---

## 🧠 The 3 Golden Concepts

1. **A Single Disk File**: The entire database (tables, indexes, triggers, schemas) is contained inside one regular file (e.g. `app.db`). Backing up your database is as simple as copying the file!
2. **Dot-Commands vs SQL Statements**:
   * **SQL statements** end with a semicolon `;` and query tables (`SELECT * FROM users;`).
   * **Dot-commands** start with a period `.`, don't need semicolons, and control the CLI environment (`.tables`, `.schema`, `.quit`).
3. **WAL Mode (Write-Ahead Logging)**: Greatly boosts concurrent read/write performance by separating active writes into a `-wal` file.

---

## ⚡ The Essential Dot-Commands

```text
.open app.db       -- Open a database file
.tables            -- List all tables in the database
.schema users      -- View the CREATE TABLE definition
.mode table        -- Format output in beautiful ASCII boxes
.headers on        -- Show column names in output
.dump              -- Dump entire database to SQL text
.quit              -- Exit SQLite CLI
```

---

## ⚡ The Daily 80/20 CLI One-Liners

```bash
# Execute SQL directly from the terminal without entering prompt
sqlite3 app.db "SELECT count(*) FROM users;"

# Dump database to a backup SQL file
sqlite3 app.db .dump > backup.sql

# Restore a database from SQL script
sqlite3 new.db < backup.sql

# Compact and optimize database file size
sqlite3 app.db "VACUUM;"
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Forgetting the semicolon `;`**:
  * *Confusion:* You press Enter and nothing happens, just a `...>` prompt.
  * *Fix:* SQLite is waiting for you to finish your SQL statement with a semicolon `;`. Type `;` and press Enter.
* **Footgun: `database is locked`**:
  * *Fix:* Turn on WAL mode: `sqlite3 app.db "PRAGMA journal_mode=WAL;"`.
