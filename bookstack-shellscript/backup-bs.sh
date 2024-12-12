#!/bin/bash

# Variables
HOME1="/home/tuonsreynit"
HOME2="/home/tuonsreynit/Desktop/Docker"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME2/backups"
FOLDERS=("bookstacks" "db" "data")  # Add folder paths
ZIP_FILE="backup_bs_${TIMESTAMP}.zip"
REMOTE_NAME="gdrive"  # Rclone remote name
REMOTE_PATH="BookStack_Backup"  # Google Drive folder name
RCLONE_CONF="$HOME1/.config/rclone/rclone.conf"  # Path to rclone config file

# Ensure rclone is properly configured
if [ ! -f "$RCLONE_CONF" ]; then
    echo "Rclone config file not found at $RCLONE_CONF. Please configure rclone first."
    exit 1
fi

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Zip the folders
echo "Creating zip archive..."
zip -r "${BACKUP_DIR}/${ZIP_FILE}" "${FOLDERS[@]}" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error creating zip file."
    exit 1
fi

echo "Zip file created: ${BACKUP_DIR}/${ZIP_FILE}"

# Upload to Google Drive
echo "Uploading to Google Drive..."
rclone --config "$RCLONE_CONF" copy "${BACKUP_DIR}/${ZIP_FILE}" "${REMOTE_NAME}:${REMOTE_PATH}/"
if [ $? -eq 0 ]; then
    echo "Upload successful!"
else
    echo "Upload failed! Check your rclone configuration or network connection."
    exit 1
fi

# Cleanup old backups locally (optional)
echo "Cleaning up old backups..."
find "$BACKUP_DIR" -type f -name "*.zip" -mtime +7 -exec rm -v {} \;

echo "Backup process completed successfully."
