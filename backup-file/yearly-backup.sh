#!/bin/bash

########################################
# YEARLY BACKUP SCRIPT
########################################

BACKUP_SOURCES=(
    "/var/www/html"
    "/etc"
    "/home"
)

BACKUP_DIR="/backup/yearly"

mkdir -p "$BACKUP_DIR"

HOSTNAME=$(hostname)
DATE=$(date +"%Y")

BACKUP_FILE="${HOSTNAME}_yearly_${DATE}.tar.gz"

echo "Starting Yearly Backup..."

tar -czpf "${BACKUP_DIR}/${BACKUP_FILE}" "${BACKUP_SOURCES[@]}"

if [ $? -eq 0 ]; then
    echo "Backup Successful: ${BACKUP_FILE}"
else
    echo "Backup Failed"
    exit 1
fi

# Keep 5 Years Backup

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +1825 -delete

echo "Yearly Backup Completed"