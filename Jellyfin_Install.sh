#!/bin/bash
sudo su - root
id
id
id
id



# Pull Jellyfin Docker image
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restoren Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."


# Define variables
DOCKER_VOLUME="jellyfin-config-restore"
BACKUP_FILE="/opt/drive_bkp/jellyfin-config_backup.tar.gz"

# Pull Jellyfin Docker image if not already pulled
docker pull jellyfin/jellyfin

# Restore Jellyfin configuration from backup
docker run --rm \
  -v $DOCKER_VOLUME:/config \
  -v $BACKUP_FILE:/restore/jellyfin-config_backup.tar.gz \
  busybox sh -c "tar xzf /restore/jellyfin-config_backup.tar.gz -C /config && chown -R 1000:1000 /config"

# Start Jellyfin Docker container
docker run -d \
  --name jellyfin \
  --network host \
  -v $DOCKER_VOLUME:/config \
  --mount type=bind,source=/workspaces/codespaces-blank,target=/media \
  jellyfin/jellyfin

echo "Jellyfin Docker container started."


echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."


sudo curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiOGQ4NWZjODYtMGQwZC00MTFhLWE1Y2EtZjc1NDliZWZiNTQ4IiwicyI6Ik9UZ3hOV1EwTWprdE9HRTVaQzAwTVRFeUxXSmhZelF0WkdNMU9EVTRaR0V6WWpVMyJ9

