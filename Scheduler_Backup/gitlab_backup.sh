#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/home/ditr_llm_server/BackUp-Nit/backup_Data/Scheduler_Backup/GitLab/${TIMESTAMP}"

# Create backup directory
mkdir -p "${BACKUP_DIR}"

# Run GitLab backup inside the container
docker exec gitlab gitlab-rake gitlab:backup:create SKIP=builds,artifacts

if [ $? -eq 0 ]; then
    echo "GitLab backup created successfully."

    # Find the latest backup file inside the GitLab container
    BACKUP_FILE=$(docker exec gitlab ls -t /var/opt/gitlab/backups/ | head -n 1)

    if [ -n "$BACKUP_FILE" ]; then
        # Copy backup file from container to the host machine
        docker cp "gitlab:/var/opt/gitlab/backups/${BACKUP_FILE}" "${BACKUP_DIR}/"

        if [ $? -eq 0 ]; then
            echo "Backup copied to ${BACKUP_DIR}/${BACKUP_FILE}"
        else
            echo "Failed to copy backup file."
        fi
    else
        echo "No backup file found in the container."
    fi
else
    echo "Backup failed."
fi