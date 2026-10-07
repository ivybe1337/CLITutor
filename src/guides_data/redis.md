# ⚡ Redis (redis-cli) for Dummies: The No-Panic Manual

> **One sentence summary:** `redis-cli` is the command-line tool for Redis, an ultra-fast in-memory key-value data store used for caching, session management, message queues, and rate-limiting.

---

## 🧠 The 3 Golden Concepts

1. **In-Memory**: Everything lives in RAM. Read and write operations take fractions of a millisecond.
2. **Data Structures**: Redis is not just strings! It natively supports Lists, Sets, Hashes, Sorted Sets (leaderboards), and Bitmaps.
3. **Time-To-Live (TTL)**: You can set an expiration timer on any key (e.g. `EXPIRE session:123 3600`). When the timer hits 0, Redis deletes it automatically.

---

## ⚡ The Daily 80/20 Commands

```text
# Test connection
PING                      # returns PONG

# Basic Key-Value
SET user:100 "Joshua"     # Store string
GET user:100              # Retrieve string
EXPIRE user:100 60        # Key expires in 60 seconds
TTL user:100              # Check remaining seconds

# Hashes (Objects)
HSET user:100 name "Joshua" role "admin"
HGET user:100 role
HGETALL user:100

# Lists (Queues)
LPUSH task_queue "job1"   # Push to left of queue
RPOP task_queue           # Pop from right of queue

# Inspection & Cleanup
DBSIZE                    # Total number of keys
FLUSHDB                   # CAUTION: Wipes all keys in current database
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Running `KEYS *` in Production**:
  * *Disaster:* `KEYS *` is a blocking O(N) operation. On a database with millions of keys, it will freeze the Redis server for seconds or minutes!
  * *Fix:* NEVER run `KEYS *`. Use `SCAN 0` for non-blocking iteration.
* **Footgun: Running Out of Memory (OOM)**:
  * *Fix:* Configure an eviction policy in `redis.conf`: `maxmemory-policy allkeys-lru` so Redis automatically discards the least-recently used keys when RAM is full.
