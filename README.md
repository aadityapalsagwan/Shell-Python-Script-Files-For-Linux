# Linux Automation Scripts

A collection of production-ready Linux Shell scripts for system administration, Kubernetes cluster deployment, server provisioning, monitoring, automation, and backup management.

---

![Linux](https://img.shields.io/badge/Linux-Supported-green)
![Bash](https://img.shields.io/badge/Bash-Scripting-blue)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.30-blue)
![Docker](https://img.shields.io/badge/Docker-Supported-2496ED)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Status](https://img.shields.io/badge/Status-Active-success)

---

## About

This repository contains a collection of Linux automation scripts designed to simplify day-to-day DevOps, Cloud, and System Administration tasks.

The scripts are organized into multiple categories including:

* Backup Automation
* Kubernetes Cluster Deployment
* Docker Installation
* Apache Installation
* Linux Monitoring
* Server Administration

These scripts are suitable for:

* Linux Administrators
* DevOps Engineers
* Cloud Engineers
* Students and Learners
* System Engineers

---

## Repository Structure

```text
scripting/
│
├── backup-file/
│   ├── daily-backup.sh
│   ├── weekly-backup.sh
│   ├── monthly-backup.sh
│   └── yearly-backup.sh
│
├── kubernetes-file/
│   ├── common.sh
│   └── master.sh
│
├── installing-file/
│   ├── install-apache-webserver.sh
│   └── install-docker.sh
│
├── monitoring-file/
│   ├── cpu-monitor.sh
│   ├── memory-monitor.sh
│   └── disk-monitor.sh
│
└── README.md
```

---

## Available Scripts

### Backup Scripts

| Script            | Description                                                           |
| ----------------- | --------------------------------------------------------------------- |
| daily-backup.sh   | Creates daily compressed backups and manages retention automatically. |
| weekly-backup.sh  | Creates weekly backup archives and removes expired backups.           |
| monthly-backup.sh | Creates monthly backup archives for long-term storage.                |
| yearly-backup.sh  | Creates yearly backup archives for disaster recovery purposes.        |

---

### Kubernetes Scripts

| Script    | Description                                                                                         |
| --------- | --------------------------------------------------------------------------------------------------- |
| common.sh | Common Kubernetes setup for Master and Worker Nodes. Installs CRI-O, kubeadm, kubelet, and kubectl. |
| master.sh | Initializes Kubernetes Control Plane and installs Calico networking.                                |

---

### Installation Scripts

| Script                      | Description                                                                |
| --------------------------- | -------------------------------------------------------------------------- |
| install-apache-webserver.sh | Installs and configures Apache Web Server.                                 |
| install-docker.sh           | Installs Docker Engine, Docker CLI, Containerd, and Docker Compose Plugin. |

---

### Monitoring Scripts

| Script            | Description                                                             |
| ----------------- | ----------------------------------------------------------------------- |
| cpu-monitor.sh    | Displays CPU utilization and top CPU-consuming processes.               |
| memory-monitor.sh | Displays memory utilization and top memory-consuming processes.         |
| disk-monitor.sh   | Displays disk usage and alerts when partitions exceed threshold limits. |

---

## Requirements

Before running any script, ensure the following requirements are met:

* Linux Operating System
* Bash Shell
* Root or Sudo Privileges
* Internet Connectivity
* Git Installed
* tar Package Installed

Verify:

```bash
bash --version
git --version
tar --version
```

---

## Installation

### Clone Repository

```bash
git clone https://github.com/aadityapalsagwan/Shell-Python-Script-Files-For-Linux.git
```

Move into repository:

```bash
cd Shell-Python-Script-Files-For-Linux
```

---

## Usage

### Make Script Executable

Example:

```bash
chmod +x backup-file/monthly-backup.sh
```

or

```bash
chmod +x installing-file/install-docker.sh
```

---

### Run Script

Example:

```bash
./backup-file/monthly-backup.sh
```

or

```bash
sudo ./installing-file/install-docker.sh
```

---

## Kubernetes Cluster Deployment

### Step 1: Run Common Setup On All Nodes

Execute on:

* Master Node
* Worker Node(s)

```bash
chmod +x kubernetes-file/common.sh

sudo ./kubernetes-file/common.sh
```

---

### Step 2: Initialize Master Node

Execute only on Master Node:

```bash
chmod +x kubernetes-file/master.sh

sudo ./kubernetes-file/master.sh
```

---

### Step 3: Join Worker Nodes

Run the generated join command on Worker Nodes:

```bash
sudo kubeadm join <MASTER-IP>:6443 \
--token <TOKEN> \
--discovery-token-ca-cert-hash sha256:<HASH>
```

---

## Docker Installation

Install Docker Engine:

```bash
chmod +x installing-file/install-docker.sh

sudo ./installing-file/install-docker.sh
```

Verify:

```bash
docker --version

docker compose version
```

---

## Backup Script Configuration

Edit the backup source directories inside the backup scripts:

```bash
BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)
```

Add or remove directories according to your environment.

---

## Backup Output Structure

```text
/backup
│
├── daily/
├── weekly/
├── monthly/
└── yearly/
```

Example:

```text
server01_monthly_2026-05.tar.gz
```

---

## Cron Job Examples

### Daily Backup

```cron
59 23 * * * /path/to/daily-backup.sh
```

### Weekly Backup

```cron
55 23 * * 0 /path/to/weekly-backup.sh
```

### Monthly Backup

```cron
50 23 28-31 * * [ "$(date +\%d -d tomorrow)" = "01" ] && /path/to/monthly-backup.sh
```

### Yearly Backup

```cron
45 23 31 12 * /path/to/yearly-backup.sh
```

---

## Features

* Production Ready Scripts
* Kubernetes Cluster Automation
* Docker Installation Automation
* Apache Web Server Installation
* Automated Backup Management
* Backup Retention Policy
* Linux Monitoring Utilities
* Easy Customization
* Beginner Friendly
* Cloud and DevOps Focused
* Cron Compatible
* Lightweight Scripts

---

## Future Enhancements

Planned additions:

* Nginx Installation Script
* Jenkins Installation Script
* Terraform Installation Script
* MySQL Backup Script
* PostgreSQL Backup Script
* AWS CLI Installation Script
* AWS S3 Backup Integration
* Email Alerting
* Slack Notifications
* Backup Encryption

---

## Author

**Aaditya Pal**

Cloud Engineer | Linux Administrator | AWS Enthusiast

GitHub:
https://github.com/aadityapalsagwan

---

## License

This project is open-source and free to use for learning, development, testing, and production environments.
