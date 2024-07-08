#!/bin/bash
sudo su - root
id
id
id
id

sudo mkdir /opt/jellyfin
sudo cd /opt/jellyfin

sudo cp /opt/drive_bkp/jellyfin_backup.zip /opt/jellyfin/
sudo unzip jellyfin_backup.zip .

# Pull Jellyfin Docker image
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restoren Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."



sudo curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiOGQ4NWZjODYtMGQwZC00MTFhLWE1Y2EtZjc1NDliZWZiNTQ4IiwicyI6Ik9UZ3hOV1EwTWprdE9HRTVaQzAwTVRFeUxXSmhZelF0WkdNMU9EVTRaR0V6WWpVMyJ9

sudo ./jellyfin.sh
