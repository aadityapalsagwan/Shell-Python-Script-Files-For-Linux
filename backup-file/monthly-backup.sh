#!/bin/bash

########################################
# MONTHLY BACKUP SCRIPT
########################################

BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)

BACKUP_DIR="/backup/monthly"

mkdir -p "$BACKUP_DIR"

HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m")

BACKUP_FILE="${HOSTNAME}_monthly_${DATE}.tar.gz"

echo "Starting Monthly Backup..."

tar -czpf "${BACKUP_DIR}/${BACKUP_FILE}" "${BACKUP_SOURCES[@]}"

if [ $? -eq 0 ]; then
    echo "Backup Successful: ${BACKUP_FILE}"
else
    echo "Backup Failed"
    exit 1
fi

# Keep 12 Months Backup

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +365 -delete

echo "Monthly Backup Completed"