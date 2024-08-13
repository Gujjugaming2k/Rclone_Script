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




curl -fsSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/filesystem.sh | sudo bash
nohup sudo filebrowser -p 8021 -r /opt/jellyfin/ > /workspaces/php_server.log 2>&1 &




# Step 2: Run rclone_script.sh
echo "Running rclone_script.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/rclone_script.sh | sudo bash

# Step 3-1: Run Rclone_Config.sh (assuming it should be run once)
echo "Running Rclone_Config.sh... 1 time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash

# Step 3-2: Run Rclone_Config.sh (assuming it should be run 2nd time)
echo "Running Rclone_Config.sh... 2nd time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash

