#!/bin/bash

# Variables
HOME1="/home/tuonsreynit"
HOME2="/home/tuonsreynit/Desktop/Docker"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME2/backups_gitlab"
FOLDERS=( "gitlab_config" "gitlab_data" "gitlab_logs" )  # Ensure absolute paths
ARCHIVE_FILE="backup_gitlab_${TIMESTAMP}.tar.gz"
REMOTE_NAME="gdrive"  # Rclone remote name
REMOTE_PATH="GitLab_Backup"  # Google Drive folder name
RCLONE_CONF="$HOME1/.config/rclone/rclone.conf"  # Path to rclone config file

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Ensure rclone is properly configured
[ ! -f "$RCLONE_CONF" ] && handle_error "Rclone config file not found at $RCLONE_CONF. Please configure rclone first."

# Ensure backup folders exist
for folder in "${FOLDERS[@]}"; do
    if [ ! -d "$folder" ]; then
        handle_error "Folder $folder does not exist or is not accessible."
    else
        echo "Folder exists: $folder"
    fi
done

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR" || handle_error "Failed to create backup directory: $BACKUP_DIR"

# Create tar.gz archive
echo "Creating tar.gz archive..."
tar -czvf "${BACKUP_DIR}/${ARCHIVE_FILE}" "${FOLDERS[@]}" || handle_error "Error creating tar.gz file."

echo "Archive created: ${BACKUP_DIR}/${ARCHIVE_FILE}"

# Upload to Google Drive
echo "Uploading to Google Drive..."
rclone --config "$RCLONE_CONF" copy "${BACKUP_DIR}/${ARCHIVE_FILE}" "${REMOTE_NAME}:${REMOTE_PATH}/" || handle_error "Upload failed! Check your rclone configuration or network connection."

echo "Upload successful!"

# (Optional) Verify upload
echo "Verifying upload..."
rclone --config "$RCLONE_CONF" check "${BACKUP_DIR}/${ARCHIVE_FILE}" "${REMOTE_NAME}:${REMOTE_PATH}/" || handle_error "Upload verification failed!"

# Cleanup old backups locally (optional)
echo "Cleaning up old backups..."
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -exec rm -v {} \; || handle_error "Failed to clean up old backups."

echo "Backup process completed successfully."
