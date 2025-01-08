#!/bin/bash
SERVER_IP=$1
if [ -z "$SERVER_IP" ]; then
    echo "Usage: $0 <SERVER_IP>"
    exit 1
fi

ZIP_FILE="backup"
REMOTE_DIR="/var/db/openproject/"
PRIVATE_KEY_PATH="/home/tuonsreynit/.ssh/id_rsa"
LOCAL_BACKUP_DIR="$PWD/op"

# Create local backup directory if it doesn't exist
mkdir -p "$LOCAL_BACKUP_DIR"

# Transfer backup from the remote server to the local machine
echo "Transferring backup from remote server to local machine..."
rsync -avz -e "ssh -i ${PRIVATE_KEY_PATH}" root@"${SERVER_IP}":"${REMOTE_DIR}/${ZIP_FILE}" "${LOCAL_BACKUP_DIR}/"
if [ $? -ne 0 ]; then
    echo "Error: Failed to transfer backup using rsync."
    exit 1
fi

# # Extract the backup locally
# echo "Extracting backup on the local machine..."
# tar -xzvf "${LOCAL_BACKUP_DIR}/${ZIP_FILE}" -C "${LOCAL_BACKUP_DIR}/"
# if [ $? -ne 0 ]; then
#     echo "Error: Failed to extract the backup file."
#     exit 1
# fi
# echo "Backup process completed successfully."
