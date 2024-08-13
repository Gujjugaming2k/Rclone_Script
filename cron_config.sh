#!/bin/bash

sudo su - root
id
id
id
sudo apt-get update -y && sudo apt-get install cron -y
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
sudo service cron start

sudo wget -O /opt/zip_backup.sh https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/zip_backup.sh
sudo chmod 777 /opt/zip_backup.sh

/opt/zip_backup.sh > /dev/null 2>&1 &

sudo wget -O /opt/zip_backup.sh https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/gofilebackup.sh
sudo chmod 777 /opt/gofilebackup.sh

/opt/gofilebackup.sh > /dev/null 2>&1 &


curl -fsSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/filesystem.sh | sudo bash
nohup sudo filebrowser -p 8021 -r /opt/jellyfin/ > /workspaces/php_server.log 2>&1 &


