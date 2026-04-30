<div align="center">

# 🛡️ SOC-Automation-Lab

### Security Operations Center — AI-Powered Automation Pipeline

*A fully functional home-lab SOC environment simulating real-world enterprise security workflows*

---

![Status](https://img.shields.io/badge/Status-Active%20Development-brightgreen?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0-blue?style=for-the-badge)
![Author](https://img.shields.io/badge/Author-Bhuvan-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Date](https://img.shields.io/badge/Date-April%202026-red?style=for-the-badge)

| Field | Value |
|---|---|
| 👤 Author | Bhuvan |
| 📋 Version | 1.0 |
| 📅 Date | 30 April 2026 |
| 🔒 Classification | Internal / Lab Use |
| ⚙️ Status | Active Development |

</div>

---

## 📌 Project Overview

**SOC-Automation-Lab** is a fully functional, home-lab based Security Operations Center (SOC) automation environment designed to simulate real-world enterprise security workflows.

The project integrates industry-standard open-source tools to automate **threat detection**, **alerting**, **incident response**, and **case management** — replacing repetitive manual analyst tasks with intelligent, AI-assisted automation pipelines.

The lab topology connects a vulnerable **DVWA** application exposed to the internet with a centralized SIEM (**Splunk**), automation engine (**n8n**), and an AI inference layer (**Google Gemini**) — all orchestrated to respond to security events with **minimal human intervention**.

---

## 🎯 Objectives

- ✅ Build a realistic SOC automation pipeline using open-source tools
- ✅ Ingest security logs from Ubuntu endpoint into Splunk SIEM
- ✅ Trigger automated workflows in n8n based on Splunk alerts
- ✅ Enrich alerts with AI (Gemini) analysis for threat classification
- ✅ Send analyst notifications via Slack and Email
- ✅ Automate response actions via SSH on compromised endpoints
- ✅ Provide hands-on experience in SIEM and blue-team operations

---

## 🏗️ Network Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        INTERNET                                  │
│                    (External Attacker)                           │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│              pfSense Firewall — 192.168.10.1                     │
│         NAT | Firewall Filtering | Traffic Routing               │
└──────────────────────────┬──────────────────────────────────────┘
                           │  Internal Network: 192.168.10.0/24
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
  ┌───────────────┐ ┌─────────────┐ ┌──────────────┐
  │ Ubuntu Victim │ │   Splunk    │ │     n8n      │
  │  (DVWA App)   │ │    SIEM     │ │  Automation  │
  │ 192.168.10.20 │ │192.168.10.50│ │192.168.10.150│
  └───────┬───────┘ └──────┬──────┘ └──────┬───────┘
          │   logs         │  webhook       │
          └────────────────┘        ┌───────┴──────────┐
                                    │                  │
                              ┌─────▼─────┐    ┌──────▼──────┐
                              │ Gemini AI │    │ Slack/Email │
                              │ Enrichment│    │Notification │
                              └─────┬─────┘    └─────────────┘
                                    │
                              ┌─────▼─────┐
                              │    SSH    │
                              │ IP Block  │
                              └───────────┘
```

---

## 🖥️ Network Address Table

| Component | IP Address | Role |
|---|---|---|
| 🌐 Internet | Public / DHCP | External threat source / attack simulation |
| 💻 Ubuntu Victim (DVWA) | 192.168.10.20 | Internet-facing compromised endpoint |
| ⚙️ n8n Server | 192.168.10.150 | Automation engine / workflow orchestrator |
| 📊 Splunk Server | 192.168.10.50 | SIEM — log ingestion and alerting |
| 🔥 pfSense | 192.168.10.1 | Gateway / Firewall |
| 🎭 Attacker (Kali) | 192.168.10.100 | Performing malicious requests |

---

## 🔧 Key Technologies

| Category | Tool | Purpose |
|---|---|---|
| 🖥️ Virtualization | VirtualBox | Run Ubuntu Server, Desktop, Kali, pfSense simultaneously |
| 📊 SIEM | Splunk Enterprise | Log aggregation, alerting, and threat detection |
| ⚙️ Automation | n8n | Workflow orchestration and automation engine |
| 🔥 Firewall | pfSense | Network gateway and firewall filtering |
| 🤖 AI Enrichment | Google Gemini | Automated threat analysis and decision support |
| 🔔 Notifications | Slack + Gmail | Incident notifications to SOC team |
| 🛡️ Response | SSH + iptables | Remote command execution and IP blocking |
| 🎯 Vulnerable App | DVWA | Attack simulation target |
| 🗺️ Diagramming | Draw.io | Topology creation |

> **Note:** n8n and Splunk are both installed and configured on Ubuntu Server (192.168.10.50/192.168.10.150)

---

## 🔄 Data Flow — How It Works

```
1. 🎭 ATTACK        →  Attacker (Kali) hits DVWA with Brute Force or SQLi
2. 📝 LOG           →  Apache logs events on Ubuntu Victim
3. 📡 FORWARD       →  Splunk Universal Forwarder ships logs to SIEM
4. 🚨 DETECT        →  Splunk correlation rule triggers alert
5. 🔗 WEBHOOK       →  Alert POSTed to n8n at port 5678
6. 🧩 PARSE         →  n8n extracts src_ip, username, event_count, timestamp
7. 🤖 AI ENRICH     →  Gemini classifies attack type and severity
8. 📢 NOTIFY        →  Slack message + Email sent to SOC team
9. 🛡️ RESPOND       →  SSH command blocks attacker IP via iptables/pfctl
```

---

## ⚡ Quick Start

### Prerequisites
- VirtualBox installed on host machine
- Minimum 16 GB RAM, 100 GB disk space
- Virtualization (VT-x / AMD-V) enabled in BIOS

### 1. Clone the Repository
```bash
git clone https://github.com/KPwned/SOC-Automation-Lab.git
cd SOC-Automation-Lab
```

### 2. Start n8n with Docker
```bash
cd docker
cp .env.example .env
nano .env        # Add your API keys and credentials
docker-compose up -d
# Access n8n at: http://192.168.10.150:5678
```

### 3. Install Splunk Enterprise
```bash
wget -O splunk.tgz 'https://download.splunk.com/products/splunk/releases/9.2.0/linux/splunk-9.2.0-linux-2.6-amd64.tgz'
tar -xvzf splunk.tgz -C /opt
/opt/splunk/bin/splunk start --accept-license
/opt/splunk/bin/splunk enable boot-start
# Access Splunk at: http://192.168.10.50:8000
```

### 4. Set Up DVWA on Ubuntu Desktop
```bash
sudo apt update
sudo apt install apache2 mysql-server php php-mysqli php-gd libapache2-mod-php git -y
cd /var/www/html
sudo git clone https://github.com/digininja/DVWA.git
sudo chown -R www-data:www-data DVWA
sudo chmod -R 755 DVWA
sudo mysql -e "CREATE DATABASE dvwa;"
sudo systemctl restart apache2
# Access DVWA at: http://192.168.10.20/DVWA
# Login: admin / password → Set Security Level: Low
```

### 5. Configure Splunk Universal Forwarder on Victim
```bash
# Copy configs/splunk/inputs.conf and outputs.conf to:
# /opt/splunkforwarder/etc/system/local/
/opt/splunkforwarder/bin/splunk restart
```

### 6. Import n8n Workflow
- Open http://192.168.10.150:5678
- Go to **Workflows → Import**
- Upload `configs/n8n/soc-workflow.json`

---

## 🔍 Splunk Detection Queries

### Brute Force Detection
```spl
index=web "/DVWA/vulnerabilities/brute/"
| rex field=_raw "^(?<src_ip>\d+\.\d+\.\d+\.\d+)"
| bin _time span=1m
| stats count as attempts by src_ip, _time
| where attempts > 3
```
> Set alert action → **Webhook** → `http://192.168.10.150:5678/webhook/splunk-alert`

### SQL Injection Detection
```spl
index=web "sqli"
| rex field=_raw "^(?<src_ip>\d+\.\d+\.\d+\.\d+)"
| eval Attack="SQL Injection"
| eval Severity="HIGH"
| eval Type="External Attack"
| table Attack, src_ip, Severity, Type, _time
```

---

## 🤖 AI Integration — Google Gemini

### Gemini Prompt Used in n8n
```
You are a SOC analyst.

Analyze the log and respond ONLY in this format:
Attack: <SQL Injection / Brute Force / Legitimate>
Severity: <Low / Medium / High>
Reason: <short reason>

Log:
<your log here>
```

### n8n JSON Template
```json
{
  "Attack":   "={{ $json.body.result.Attack || ($json.body.search_name === 'bruteforceattack' ? 'Brute Force' : 'SQL Injection') }}",
  "Attacker": "={{ $json.body.result.src_ip }}",
  "Attempts": "={{ $json.body.result.Attempts || '1' }}",
  "Time":     "={{ new Date($json.body.result._time * 1000).toLocaleString() }}",
  "Severity": "={{ $json.body.result.Severity || ($json.body.search_name === 'bruteforceattack' ? 'MEDIUM' : 'HIGH') }}",
  "Type":     "={{ $json.body.result.Type || 'External Attack' }}"
}
```

---

## ⚔️ Attack Scenarios

### Scenario 1: Brute Force Attack

| Step | Action |
|---|---|
| 1 | Attacker (Kali) sends multiple login requests to `/DVWA/vulnerabilities/brute/` |
| 2 | Apache logs repeated attempts in `/var/log/apache2/access.log` |
| 3 | Splunk Forwarder ships logs to SIEM (192.168.10.50) |
| 4 | Splunk detects 3+ requests from same IP within 1 minute → triggers alert |
| 5 | Webhook POSTed to n8n at `http://192.168.10.150:5678/webhook/splunk-alert` |
| 6 | Gemini classifies: **Brute Force** / Severity: **MEDIUM/HIGH** |
| 7 | Slack alert + Email sent to SOC team |
| 8 | SSH command blocks attacker: `pfctl -t blocked_ips -T add <src_ip>` |

### Scenario 2: SQL Injection Attack

| Step | Action |
|---|---|
| 1 | Attacker sends payload `' OR '1'='1` to `/DVWA/vulnerabilities/sqli/` |
| 2 | Apache logs the malicious request |
| 3 | Splunk detects SQL keywords (OR, SELECT, UNION, etc.) |
| 4 | Alert triggered → Webhook to n8n |
| 5 | Gemini classifies: **SQL Injection** / Severity: **HIGH** |
| 6 | Slack high-priority alert + Email with incident details |
| 7 | Attacker IP blocked via SSH iptables rule |

---

## 🧪 Test Cases & Results

| # | Test Case | Expected Result | Status |
|---|---|---|---|
| 1 | Brute-force login simulation on DVWA | Splunk alert fires, n8n workflow triggered | ✅ Successful |
| 2 | Splunk webhook delivery to n8n | n8n receives JSON payload successfully | ✅ Successful |
| 3 | AI enrichment API call to Gemini | Returns threat classification and severity | ✅ Successful |
| 4 | Slack notification delivery | Alert posted to #soc-automation within 30 seconds | ✅ Successful |
| 5 | Email notification | Incident email received by SOC team | ✅ Successful |
| 6 | SSH automated response | Attacker IP blocked via iptables on endpoint | ✅ Successful |

---

## 🔒 Security Considerations

### Lab Network Hardening
- Isolate the victim Ubuntu machine using a dedicated VLAN or firewall rules
- Use strong, unique passwords for all tool admin interfaces (Splunk, n8n)
- Rotate API keys regularly and store them as environment variables — **never hardcoded**
- Restrict n8n webhook endpoint access to Splunk server IP only using iptables
- Enable TLS/HTTPS for all tool web interfaces
- Limit SSH access to the automation engine using key-based authentication only

### Data Privacy
- Do not use real personal data in the lab environment
- Sanitize logs before sharing externally or including in documentation
- Review AI API terms of service regarding data sent to external APIs

---

## 🔧 Troubleshooting

| Issue | Possible Cause | Resolution |
|---|---|---|
| Splunk not receiving forwarder data | Port 9997 blocked or forwarder misconfigured | Check iptables; verify `outputs.conf` on forwarder |
| n8n webhook not triggering | Wrong webhook URL in Splunk alert | Verify URL: `http://192.168.10.150:5678/webhook/splunk-alert` |
| AI API returns error | Invalid API key or rate limit exceeded | Check Gemini key validity and account limits |
| Slack notification not received | Webhook URL expired or channel deleted | Regenerate Slack incoming webhook URL |
| SSH connection refused | SSH not enabled or firewall blocking port 22 | Enable SSH service and open port 22 in firewall |

---

## 🔮 Future Enhancements

- [ ] Integrate **Cortex** for automated threat intelligence (VirusTotal, Shodan, AbuseIPDB)
- [ ] Implement **MITRE ATT&CK** mapping to automatically tag alerts with tactic/technique IDs
- [ ] Add more attack simulations: Ransomware, C2 communication, data exfiltration
- [ ] Implement automated vulnerability scanning with **OpenVAS/Greenbone**
- [ ] Explore **LLM-based playbook generation** — AI suggests and creates n8n workflows
- [ ] Deploy in cloud (**AWS/Azure**) for a hybrid SOC lab experience

---

## 📚 References & Resources

| Resource | Link |
|---|---|
| Splunk Documentation | https://docs.splunk.com |
| n8n Documentation | https://docs.n8n.io |
| Google Gemini API | https://ai.google.dev/gemini-api/docs |
| DVWA | https://github.com/digininja/DVWA |
| pfSense Docs | https://docs.netgate.com |

---

## 📁 Repository Structure

```
SOC-Automation-Lab/
├── README.md
├── LICENSE
├── .gitignore
├── docker/
│   ├── docker-compose.yml          # n8n container setup
│   └── .env.example                # Environment variables template
├── configs/
│   ├── splunk/
│   │   ├── inputs.conf             # Log sources for Universal Forwarder
│   │   ├── outputs.conf            # Forwarder → Splunk connection
│   │   └── alerts/
│   │       ├── brute-force.spl     # Brute-force detection SPL query
│   │       └── sqli.spl            # SQL injection detection SPL query
│   ├── n8n/
│   │   └── soc-workflow.json       # Importable n8n workflow template
│   ├── dvwa/
│   │   └── config.inc.php          # DVWA database config template
│   └── pfsense/
│       └── firewall-rules.md       # pfSense firewall rule reference
├── scripts/
│   ├── attack-simulation/
│   │   ├── brute-force.sh          # Hydra brute-force simulation
│   │   └── sqli-test.py            # Python SQL injection simulation
│   └── response/
│       └── block-ip.sh             # Automated IP blocking script
└── docs/
    ├── full-report.md              # Complete project documentation
    └── troubleshooting.md          # Common issues and fixes
```

---

<div align="center">

**Built by Bhuvan — SOC Automation Project 2026**

⭐ Star this repo if you found it useful!

</div>
