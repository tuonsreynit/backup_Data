#!/bin/bash

# Variables
HOME1="/home/tuonsreynit"
HOME2="/home/tuonsreynit/Desktop/Docker"
BACKUP_DIR="$HOME2/backups"            # Local directory to store downloaded backups temporarily
RESTORE_DIR="$HOME2/restore"          # Directory to extract and restore files

# Create necessary directories
mkdir -p "$BACKUP_DIR"
mkdir -p "$RESTORE_DIR"

# Prompt user for Google Drive shareable link
echo "Enter the Google Drive shareable link for the backup file:"
read -r GDRIVE_LINK

# Extract folders ID from the link using improved regex
if [[ $GDRIVE_LINK =~ ^https://drive\.google\.com/folders/d/([a-zA-Z0-9_-]+) ]]; then
    FILE_ID=${BASH_REMATCH[1]}
elif [[ $GDRIVE_LINK =~ ^https://drive\.google\.com/open\?id=([a-zA-Z0-9_-]+) ]]; then
    FILE_ID=${BASH_REMATCH[1]}
else
    echo "Invalid Google Drive link. Please provide a valid link."
    exit 1
fi

# Prompt user for output file name
echo "Enter the desired output file name (e.g., backup_bs.zip):"
read -r BACKUP_FILE

# Download the file using wget
echo "Downloading the backup file from Google Drive..."
CONFIRM_TOKEN=$(wget --quiet --save-cookies /tmp/cookies.txt \
    --keep-session-cookies --no-check-certificate \
    "https://drive.google.com/uc?export=download&id=${FILE_ID}" \
    -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p')

wget --load-cookies /tmp/cookies.txt \
    "https://drive.google.com/uc?export=download&confirm=${CONFIRM_TOKEN}&id=${FILE_ID}" \
    -O "${BACKUP_DIR}/${BACKUP_FILE}" && rm -rf /tmp/cookies.txt

if [ ! -f "${BACKUP_DIR}/${BACKUP_FILE}" ]; then
    echo "Failed to download the backup file. Check the link or your network connection."
    exit 1
fi

# Extract the backup file
echo "Extracting ${BACKUP_FILE} to $RESTORE_DIR..."
unzip -o "${BACKUP_DIR}/${BACKUP_FILE}" -d "$RESTORE_DIR" >/dev/null
if [ $? -ne 0 ]; then
    echo "Failed to extract the backup file."
    exit 1
fi

echo "Backup restored successfully to $RESTORE_DIR."
