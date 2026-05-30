#!/bin/bash

########################################
# DAILY BACKUP SCRIPT
########################################

BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)

BACKUP_DIR="/backup/daily"

mkdir -p "$BACKUP_DIR"

HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="${HOSTNAME}_daily_${DATE}.tar.gz"

echo "Starting Daily Backup..."

tar -czpf "${BACKUP_DIR}/${BACKUP_FILE}" "${BACKUP_SOURCES[@]}"

if [ $? -eq 0 ]; then
    echo "Backup Successful: ${BACKUP_FILE}"
else
    echo "Backup Failed"
    exit 1
fi

# Keep 7 Days Backup

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

echo "Daily Backup Completed"