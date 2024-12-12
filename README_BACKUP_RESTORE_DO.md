## 1. Setting up GitLab, BookStack, OpenProject using docker compose
### Prerequisite
* Download Docker and docker compose into to your local machine and DO.

### a. GitLab
* Create the ```docker-compose.gitlab.yml``` file. Put the GitLab configuration script :
```shell
version: '3.8'

services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    restart: always
    hostname: 'localhost'
    environment:
      GITLAB_ROOT_PASSWORD: 'your_root_password' 
    ports:
      - '8082:80'  # HTTP link to public port 8082 and can use another port
      - '443:443'  # HTTPS
      - '2222:22'  # SSH
    volumes:
      - ./dir-outsite-your-container/data:/var/opt/gitlab  
      - ./dir-outsite-your-container/logs:/var/log/gitlab  
      - ./dir-outsite-your-container/config:/etc/gitlab
      - ./dir-outsite-your-container/backups:/var/opt/gitlab/backups:rw
    shm_size: '256m'
```
 into the ```docker-compose.gitlab.yml``` file and run it by using command line ```docker compose -f docker-compose.gitlab.yml up -d ```.
 * Open the web browser with url ```http://localhost:8082```.
 * Default user and password admin are username: ```root``` with password as put in the script : ```your_root_password```.

### b. BookStack
* Create the ```docker-compose.bs.yml``` file, then write the script : 
```shell
version: '3.8'
services:
  bookstack:
    image: lscr.io/linuxserver/bookstack:latest
    container_name: bookstack
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - APP_URL="http://localhost:8080/"
      - APP_KEY="base64:bVV6Byw//nNF5x0RqMW4iWCnBtcrrEZ2ZyFHi4ev+VY=" 
      - DB_HOST=db
      - DB_PORT=3306
      - DB_USERNAME=root
      - DB_PASSWORD=bookstack123
      - DB_DATABASE=bookstack
    volumes:
      - ./dir-outsite-your-container/config:/config
    ports:
      - 8080:80
    restart: unless-stopped
    depends_on:
      - db

  db:
    image: mysql:8.0
    container_name: db
    cap_add:
      - SYS_NICE
    restart: always
    environment:
      - MYSQL_DATABASE=bookstack
      - MYSQL_ROOT_PASSWORD=bookstack123
    ports:
      - '3306:3306'
    volumes:
      - ./dir-outsite-your-container/db:/var/lib/mysql
      - ./dir-outsite-your-container/db/init.sql:/docker-entrypoint-initdb.d/init.sql
```
* Start running it with command line ```docker compose -f docker-compose.bs.yml up -d```. 
* Open the web page with url ```http://localhost:8080```. 
* Try to get your APP_KEY command line ```docker run -it --rm --entrypoint /bin/bash lscr.io/linuxserver/bookstack:latest appkey``` to get your app key replace with your app key.
* Login with default admin user 
  - admin email: ```admin@admin.com```
  - admin user name: ```Admin```
  - admin password: ```password```

### c. OpenProject
* Create the ```docker-compose.op.yml``` file, then write the script :
```shell
version: '3.8'
services:
  openproject:
    image: openproject/openproject:15
    container_name: openproject
    ports:
      - "8081:80"
    environment:
      OPENPROJECT_HTTPS: false
      OPENPROJECT_SECRET_KEY_BASE: "secret"
      OPENPROJECT_HOST__NAME: "localhost:8081"
      OPENPROJECT_DEFAULT__LANGUAGE: "en"
      
    volumes:
      - ./dir-outsite-your-container/pgdata:/var/openproject/pgdata 
      - ./dir-outsite-your-container/assets:/var/openproject/assets 
```
* Start running it with command line ```docker compose -f docker-compose.op.yml up -d```. 
* Open the web page with url ```http://localhost:8081```. 
* Login with default admin user 
  - admin user name: ```admin```
  - admin password: ```admin```

## 2. Backup GitLab, BookStack and OpenProject data from local machine to Digital Ocean droplet
* By running on the local machine, the docker volumes have mount the data outside with data inside docker container. So, you can use the directory data have mounted outside docker container to restore in DO by using the Shell Script. Create file ```backup-restore-to-do.sh``` and fill this:
```shell
#!/bin/bash

SERVER_IP=$1
HOME="/your-current-dir"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/backup"
FOLDERS=("dir-outside-your-container" "dir-outside-your-container" "...")  
ZIP_FILE="backup_${TIMESTAMP}.tar.gz"
REMOTE_DIR="/dir-on-do"
PRIVATE_KEY_PATH="/path-of-your-private-key"

# Ensure SERVER_IP is provided
if [ -z "$SERVER_IP" ]; then
    echo "Usage: $0 <SERVER_IP>"
    exit 1
fi

mkdir -p "$BACKUP_DIR"

# Check if folders exist
for folder in "${FOLDERS[@]}"; do
    if [ ! -d "$folder" ]; then
        echo "Directory $folder does not exist. Skipping."
        exit 1
    fi
done

echo "Creating tar archive..."
tar -zcf "${BACKUP_DIR}/${ZIP_FILE}" "${FOLDERS[@]}"
if [ $? -ne 0 ]; then
    echo "Error creating tar file."
    exit 1
fi

echo "Backup archive created: ${BACKUP_DIR}/${ZIP_FILE}"

echo "Transferring backup to remote server..."
rsync -avz -e "ssh -i ${PRIVATE_KEY_PATH}" "${BACKUP_DIR}/${ZIP_FILE}" root@"${SERVER_IP}":"${REMOTE_DIR}/"
if [ $? -ne 0 ]; then
    echo "Error during rsync."
    exit 1
fi

echo "Extracting backup on remote server..."
ssh -i "${PRIVATE_KEY_PATH}" root@"${SERVER_IP}" "mkdir -p '${REMOTE_DIR}/extracted' && tar -xzvf '${REMOTE_DIR}/${ZIP_FILE}' -C '${REMOTE_DIR}/extracted/'"
if [ $? -ne 0 ]; then
    echo "Error extracting backup on remote server."
    exit 1
fi

echo "Backup process completed successfully."
```
```Note:``` make sure your local or current machine can ssh to the DO.
* To running the shell script is to make permission to execute the shell script ```sudo chmod +x backup-restore-to-do.sh``` and run it ``` sudo bash backup-restore-to-do.sh <your-do-public-ip> ```.
* Can Using the shell script to the three Applications [GitLab, BookStack, and OpenProject] and modify as you wish.
* After it run successfully, you can see ``` REMOTE_DIR/extracted ``` with your backup data inside your DO.

__-> You can use the same docker compose file as you have installed above and modify some config path.__
### a. BookStack
```shell
version: '3.8'
services:
  bookstack:
    image: lscr.io/linuxserver/bookstack:latest
    container_name: bookstack
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - APP_URL="http://<your-public-do-ip>:8080/"
      - APP_KEY="base64:bVV6Byw//nNF5x0RqMW4iWCnBtcrrEZ2ZyFHi4ev+VY="
      - DB_HOST=db
      - DB_PORT=3306
      - DB_USERNAME=root
      - DB_PASSWORD=bookstack123
      - DB_DATABASE=bookstack
    volumes:
      - ./dir-remote-path/extracted/bookstacks/config:/config
    ports:
      - 8080:80
    restart: unless-stopped
    depends_on:
      - db

  db:
    image: mysql:8.0
    container_name: db
    cap_add:
      - SYS_NICE
    restart: always
    environment:
      - MYSQL_DATABASE=bookstack
      - MYSQL_ROOT_PASSWORD=bookstack123
    ports:
      - '3306:3306'
    volumes:
      - ./dir-remote-path/extracted/data/db:/var/lib/mysql
      - ./dir-remote-path/extracted/db/init.sql:/docker-entrypoint-initdb.d/init.sql
```
And running it with ```docker compose -f docker-compose.bs.yml up -d```. Then open the web page with url ```http://<your-public-do-ip>:8080```.
Try to log in with your old username and password, your old data also had as well.
### b. OpenProject
```shell
version: '3.8'
services:
  openproject:
    image: openproject/openproject:15
    container_name: openproject
    ports:
      - "8081:80" # Maps port 8081 on the host to port 80 in the container
    environment:
      OPENPROJECT_HTTPS: false      # if your have ssl to your server can replace it to true
      OPENPROJECT_SECRET_KEY_BASE: "secret"
      OPENPROJECT_HOST__NAME: "<your-public-do-ip>:8081"
      OPENPROJECT_DEFAULT__LANGUAGE: "en"
      
    volumes:
      - ./backup_op/extracted/pgdata:/var/openproject/pgdata 
      - ./backup_op/extracted/assets:/var/openproject/assets 
```
Same running it with ```docker compose -f docker-compose.op.yml up -d```. Then open the web page with url ```http://<your-public-do-ip>:8081```.
Try to log in with your old username and password, your old data also had as well.

### c. GitLab
```shell
version: '3.8'
services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    restart: always
    hostname: '<your-public-do-ip>'
    environment:
      GITLAB_ROOT_PASSWORD: '<your-root-password>' 
    ports:
      - '8082:80'  # HTTP
      - '443:443'  # HTTPS
      - '2222:22'  # SSH
    volumes:
      - ./backups_gitlab/extracted/data/gitlab_data:/var/opt/gitlab:rw      
      - ./backups_gitlab/extracted/data/gitlab_logs:/var/log/gitlab:rw   
      - ./backups_gitlab/extracted/data/gitlab_config:/etc/gitlab:rw      
    shm_size: '256m'     # set for the available size of docker container
```
Same running it with ```docker compose -f docker-compose.gitlab.yml up -d```. Then open the web page with url ```http://<your-public-do-ip>:8082```.
Try to log in with your old username and password, your old data also had as well.

``Note:`` GitLab provided the ability to back up and restore GitLab instances through Rake tasks.
* To back up data your can run ``` docker exec -it <gitlab_container_name> gitlab-rake gitlab:backup:create```. 
* Check the Back-up file ```docker exec -it <gitlab_container_name> ls /var/opt/gitlab/backups/```, you will see the back-up file name ```*_gitlab_backup.tar```.
* To restore the data have backed up follow this:
  - Stop some service in gitlab ```docker exec -it <gitlab_container_name> gitlab-ctl stop unicorn```, ``` docker exec -it <gitlab_container_name> gitlab-ctl stop sidekiq``` and ```docker exec -it <gitlab_container_name> gitlab-ctl stop puma```.
  - Check the status of those services ```docker exec -it <gitlab_container_name> gitlab-ctl status```.
  - Start restore the data ```docker exec -it <gitlab_container_name> gitlab-rake gitlab:backup:restore BACKUP = "*_gitlab_backup.tar" ```.
  - Restart all Gitlab components and services ```docker exec -it <gitlab_container_name> gitlab-ctl reconfigure``` and  ```docker exec -it <gitlab_container_name> gitlab-ctl restart```.

Finally, You can see the all old data restore to the server.