#!/bin/bash

sudo su - root
id
id
id
sudo apt-get update -y && sudo apt-get install cron -y
sudo service cron start
(crontab -l | grep -v "0 2 * * * /opt/zip_backup.sh") | crontab -
sudo wget -O /opt/zip_backup.sh https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/zip_backup.sh
sudo chmod 777 /opt/zip_backup.sh
