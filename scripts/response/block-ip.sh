#!/bin/bash
# Usage: ./block-ip.sh <attacker_ip>
ATTACKER_IP="$1"
iptables -I INPUT -s "$ATTACKER_IP" -j DROP
iptables -I FORWARD -s "$ATTACKER_IP" -j DROP
echo "Blocked: $ATTACKER_IP"
