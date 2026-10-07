# 🥣 jq for Dummies: The No-Panic Manual

> **One sentence summary:** `jq` is a lightweight command-line JSON processor—like `sed` and `awk` specifically built for JSON data, letting you slice, filter, map, and transform messy API outputs in one line.

---

## 🧠 The 3 Golden Concepts

1. **The Identity Filter (`.`)**: The simplest filter. It takes raw JSON input and pretty-prints it with indentation and syntax colors.
2. **Key Access (`.key`) & Array Iteration (`.[]`)**:
   * `.user.name`: Drills down into nested object keys.
   * `.items[]`: Unpacks an array into individual items.
   * `.items[0]`: Grabs the first item of an array.
3. **Piping Inside jq (`|`)**: You can pipe intermediate results within the jq expression itself: `.users[] | .email`.

---

## ⚡ The Top Daily Recipes

```bash
# 1. Pretty print ugly minified JSON
cat payload.json | jq .

# 2. Extract an unquoted raw string (-r flag is key!)
curl -s https://api.github.com/users/ivybe1337 | jq -r '.login'

# 3. Extract a specific field from every object in an array
curl -s https://api.github.com/users/ivybe1337/repos | jq '.[].name'

# 4. Filter array objects based on condition
cat users.json | jq '.[] | select(.age >= 18)'

# 5. Transform into a new custom JSON structure
cat users.json | jq '[.[] | {id: .id, fullName: "\(.firstName) \(.lastName)"}]'

# 6. Get array length or keys of an object
cat data.json | jq 'keys'
cat data.json | jq 'length'
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Extra Quotes around extracted strings**:
  * *Disaster:* Running `TOKEN=$(cat auth.json | jq .token)` puts `"eyJhb..."` with literal quotes into your bash variable!
  * *Fix:* Always pass `-r` (raw output): `TOKEN=$(cat auth.json | jq -r .token)`.
* **Footgun: Null Reference Errors on missing keys**:
  * *Fix:* Use the optional chaining operator `?`: `.user?.address?.zip` returns `null` instead of throwing an error.
