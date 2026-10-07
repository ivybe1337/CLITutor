# 🎯 Nmap for Dummies: The No-Panic Manual

> **One sentence summary:** `nmap` (Network Mapper) discovers active hosts on a computer network and identifies open ports, operating systems, and running network services for security auditing and debugging.

---

## 🧠 The 3 Golden Concepts

1. **Host Discovery vs Port Scanning**:
   * **Host discovery** (`-sn` ping scan): Finds out which devices are online on a subnet without probing their ports.
   * **Port scanning**: Checks which TCP/UDP ports (e.g. 22 SSH, 80 HTTP, 443 HTTPS) are open on an active host.
2. **SYN Stealth Scan (`-sS`)**: The default root scan. Sends TCP SYN packets; if a SYN-ACK returns, the port is open, and Nmap immediately resets the connection without finishing the full 3-way handshake.
3. **Service & Version Detection (`-sV`)**: Probes open ports to discover what exact software and version is listening (e.g., `OpenSSH 9.2` vs generic `ssh`).

---

## ⚡ The Daily 80/20 Commands

```bash
# 1. Discover all active devices on your local Wi-Fi/subnet
nmap -sn 192.168.1.0/24

# 2. Fast scan of the top 100 most common ports on a host
nmap -F 192.168.1.50

# 3. Comprehensive scan: detect OS, services, and run default vulnerability scripts (-A)
nmap -A 192.168.1.50

# 4. Scan a specific port or range of ports
nmap -p 80,443,8000-8080 myhost.com

# 5. Scan all 65,535 TCP ports
nmap -p- 192.168.1.50
```

---

## 🛑 The Footguns & How to Avoid Them

* **Footgun: Scanning networks you don't own**:
  * *Warning:* Port scanning public websites or servers without written permission can trigger security alarms or be flagged as an unauthorized attack. Only scan your own devices, local network, or authorized pentesting targets.
