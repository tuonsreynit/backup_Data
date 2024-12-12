#!/bin/bash

SERVER_IP=$1
# Ensure SERVER_IP is provided
if [ -z "$SERVER_IP" ]; then
    echo "Usage: $0 <SERVER_IP>"
    exit 1
fi
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ZIP_FILE="backup_op_${TIMESTAMP}.tar.gz"
REMOTE_DIR="/root/backup_op"
PRIVATE_KEY_PATH="/home/tuonsreynit/.ssh/id_rsa"
# Define variables
LOCAL_BACKUP_DIR="$PWD/local_backup_op"  # Local directory where backup will be saved  # Remote backup location on the droplet


# Create local backup directory if not exists
mkdir -p "$LOCAL_BACKUP_DIR"

# Transfer backup from remote server to local machine
echo "Transferring backup from remote server to local machine..."
rsync -avz -e "ssh -i ${PRIVATE_KEY_PATH}" root@"${SERVER_IP}":"${REMOTE_DIR}/${ZIP_FILE}" "${LOCAL_BACKUP_DIR}/"
if [ $? -ne 0 ]; then
    echo "Error during rsync."
    exit 1
fi

# Extract backup locally
echo "Extracting backup on local machine..."
tar -xzvf "${LOCAL_BACKUP_DIR}/${ZIP_FILE}" -C "${LOCAL_BACKUP_DIR}/"
if [ $? -ne 0 ]; then
    echo "Error extracting backup on local machine."
    exit 1
fi

echo "Backup process completed successfully."
