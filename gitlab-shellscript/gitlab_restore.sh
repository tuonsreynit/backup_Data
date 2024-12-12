#!/bin/bash

# Variables
HOME1="/home/tuonsreynit"
HOME2="/home/tuonsreynit/Desktop/Docker"
BACKUP_DIR="$HOME2/backups_gitlab"            # Local directory to store downloaded backups temporarily
RESTORE_DIR="$HOME2/restore_gitlab"          # Directory to extract and restore files
REMOTE_NAME="gdrive"                 # Rclone remote name
REMOTE_PATH="GitLab_Backup"       # Google Drive folder name
RCLONE_CONF="$HOME1/.config/rclone/rclone.conf"  # Path to rclone config file

# Ensure rclone is properly configured
if [ ! -f "$RCLONE_CONF" ]; then
    echo "Rclone config file not found at $RCLONE_CONF. Please configure rclone first."
    exit 1
fi

# Create necessary directories
mkdir -p "$BACKUP_DIR"
mkdir -p "$RESTORE_DIR"

# List available backups on Google Drive
echo "Fetching available backups from Google Drive..."
BACKUP_LIST=$(rclone --config "$RCLONE_CONF" lsf "${REMOTE_NAME}:${REMOTE_PATH}/" | grep "backup_gitlab_.*\.tar\.gz")
if [ -z "$BACKUP_LIST" ]; then
    echo "No backup files found on Google Drive."
    exit 1
fi

echo "Available backup files:"
echo "$BACKUP_LIST"

# Prompt user to select a backup file
echo "Enter the name of the backup file to restore:"
read -r BACKUP_FILE

# Check if the file exists on the remote
rclone --config "$RCLONE_CONF" ls "${REMOTE_NAME}:${REMOTE_PATH}/${BACKUP_FILE}" >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "The specified backup file does not exist on Google Drive."
    exit 1
fi

# Download the selected backup file
echo "Downloading ${BACKUP_FILE} from Google Drive..."
rclone --config "$RCLONE_CONF" copy "${REMOTE_NAME}:${REMOTE_PATH}/${BACKUP_FILE}" "$BACKUP_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to download backup file. Check your network or rclone configuration."
    exit 1
fi

# Extract the backup file
echo "Extracting ${BACKUP_FILE} to $RESTORE_DIR..."
tar -xzvf "${BACKUP_DIR}/${BACKUP_FILE}" -C "$RESTORE_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to extract the backup file."
    exit 1
fi

echo "Backup restored successfully to $RESTORE_DIR."
