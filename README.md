# Linux Automation Scripts

A collection of production-ready Linux Shell scripts for system administration, server provisioning, automation, and backup management.

---

![Linux](https://img.shields.io/badge/Linux-Supported-green)
![Bash](https://img.shields.io/badge/Bash-Scripting-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Status](https://img.shields.io/badge/Status-Active-success)

---

## Repository Structure

```text
SCRIPTING/
│
├── backup-file/
│   ├── daily-backup.sh
│   ├── weekly-backup.sh
│   ├── monthly-backup.sh
│   └── yearly-backup.sh
│
├── installing-file/
│   └── install-apache-webserver.sh
│
└── README.md
```

---

## Available Scripts

### Backup Scripts

| Script | Description |
|----------|-------------|
| daily-backup.sh | Creates a daily compressed backup and removes old backups based on retention policy. |
| weekly-backup.sh | Creates a weekly compressed backup and manages backup retention. |
| monthly-backup.sh | Creates a monthly compressed backup archive. |
| yearly-backup.sh | Creates a yearly backup archive for long-term storage. |

---

### Installation Scripts

| Script | Description |
|----------|-------------|
| install-apache-webserver.sh | Installs and configures Apache Web Server on Linux systems. |

---

## Requirements

Before running any script, ensure the following requirements are met:

- Linux Operating System
- Bash Shell
- Root or Sudo Privileges
- Internet Connectivity (for installation scripts)
- tar package installed (for backup scripts)

Verify:

```bash
bash --version
tar --version
```

---

## Usage

### Step 1: Clone Repository

```bash
git clone https://github.com/aadityapalsagwan/Shell-Python-Script-Files-For-Linux.git

```

Move into repository:

```bash
cd SCRIPTING
```

---

### Step 2: Make Script Executable

Example:

```bash
chmod +x backup-file/monthly-backup.sh
```

or

```bash
chmod +x installing-file/install-apache-webserver.sh
```

---

### Step 3: Run Script

Example:

```bash
./backup-file/monthly-backup.sh
```

or

```bash
sudo ./installing-file/install-apache-webserver.sh
```

---

## Backup Script Configuration

Edit the source directories inside the script:

```bash
BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)
```

Add or remove directories according to your requirements.

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

Generated backup example:

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

- Lightweight Scripts
- Easy Customization
- Production Ready
- Automated Backup Retention
- Apache Installation Automation
- Cron Compatible
- Linux Server Friendly
- No External Dependencies

---

## Future Enhancements

Planned features:

- MySQL Backup Script
- PostgreSQL Backup Script
- Nginx Installation Script
- Docker Installation Script
- AWS S3 Backup Integration
- Email Notification Support
- Backup Encryption

---

## Author: **Aaditya Pal**

Cloud Engineer | Linux Administrator | AWS Enthusiast

---

## License

This project is open-source and free to use for learning, development, and production environments.