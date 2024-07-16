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


sudo wget -O /opt/index.php https://raw.githubusercontent.com/prasathmani/tinyfilemanager/master/tinyfilemanager.php
cd /opt/
nohup sudo php -S 127.0.0.1:8021 > /workspaces/php_server.log 2>&1 &
