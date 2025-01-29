#!/bin/bash

PASSWORD=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/home/ditr_llm_server/BackUp-Nit/backup_Data/Scheduler_Backup/BookStack/${TIMESTAMP}"

mkdir -p "${BACKUP_DIR}"

docker exec bookstack-mysql bash -c "mysqldump -u bookstack_real -p'$PASSWORD' bookstackrealdb" > "${BACKUP_DIR}/${TIMESTAMP}_bs.backup.sql"

if [ $? -eq 0 ]; then
    echo "Backup completed at ${TIMESTAMP}. Saved to ${BACKUP_DIR}/${TIMESTAMP}_bs.backup.sql" 
else
    echo "Backup failed."
fi