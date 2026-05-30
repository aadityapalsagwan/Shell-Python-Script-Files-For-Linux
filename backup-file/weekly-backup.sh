#!/bin/bash

########################################
# WEEKLY BACKUP SCRIPT
########################################

BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)

BACKUP_DIR="/backup/weekly"

mkdir -p "$BACKUP_DIR"

HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="${HOSTNAME}_weekly_${DATE}.tar.gz"

echo "Starting Weekly Backup..."

tar -czpf "${BACKUP_DIR}/${BACKUP_FILE}" "${BACKUP_SOURCES[@]}"

if [ $? -eq 0 ]; then
    echo "Backup Successful: ${BACKUP_FILE}"
else
    echo "Backup Failed"
    exit 1
fi

# Keep 8 Weeks Backup

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +56 -delete

echo "Weekly Backup Completed"