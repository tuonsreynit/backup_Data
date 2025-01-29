#!/bin/bash

PASSWORD=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/home/ditr_llm_server/BackUp-Nit/backup_Data/Scheduler_Backup/OpenProject/${TIMESTAMP}"

mkdir -p "${BACKUP_DIR}"
# Run pg_dump and save backup to host machine
docker exec -i compose-db-1 bash -c "PGPASSWORD='${PASSWORD}' pg_dump -h 127.0.0.1 -d openrealdb -U open_real -p 5432 -x -O" > "${BACKUP_DIR}/${TIMESTAMP}_op.backup.sql"

if [ $? -eq 0 ]; then
    echo "Backup completed at ${TIMESTAMP}. Saved to ${BACKUP_DIR}/${TIMESTAMP}_op.backup.sql"
else
    echo "Backup failed."
fi