#!/bin/bash

SERVER_IP=$1
HOME="/home/tuonsreynit/Desktop/Docker"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/backup_bs"
FOLDERS=("bookstacks" "db" "data")  # Add folder paths
ZIP_FILE="backup_bs_${TIMESTAMP}.tar.gz"
REMOTE_DIR="/root/backup_bs"
PRIVATE_KEY_PATH="/home/tuonsreynit/.ssh/id_rsa"

# Ensure SERVER_IP is provided
if [ -z "$SERVER_IP" ]; then
    echo "Usage: $0 <SERVER_IP>"
    exit 1
fi

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Check if folders exist
for folder in "${FOLDERS[@]}"; do
    if [ ! -d "$folder" ]; then
        echo "Directory $folder does not exist. Skipping."
        exit 1
    fi
done

# Create tarball
echo "Creating tar archive..."
tar -zcf "${BACKUP_DIR}/${ZIP_FILE}" "${FOLDERS[@]}"
if [ $? -ne 0 ]; then
    echo "Error creating tar file."
    exit 1
fi

echo "Backup archive created: ${BACKUP_DIR}/${ZIP_FILE}"

# Transfer backup to remote server
echo "Transferring backup to remote server..."
rsync -avz -e "ssh -i ${PRIVATE_KEY_PATH}" "${BACKUP_DIR}/${ZIP_FILE}" root@"${SERVER_IP}":"${REMOTE_DIR}/"
if [ $? -ne 0 ]; then
    echo "Error during rsync."
    exit 1
fi

# Extract backup on remote server
echo "Extracting backup on remote server..."
ssh -i "${PRIVATE_KEY_PATH}" root@"${SERVER_IP}" "mkdir -p '${REMOTE_DIR}/extracted' && tar -xzvf '${REMOTE_DIR}/${ZIP_FILE}' -C '${REMOTE_DIR}/extracted/'"
if [ $? -ne 0 ]; then
    echo "Error extracting backup on remote server."
    exit 1
fi

echo "Backup process completed successfully."
