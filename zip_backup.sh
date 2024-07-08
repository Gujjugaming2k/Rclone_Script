#!/bin/bash
sudo su - root
id
id
id
id
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."


# Define variables
CONTAINER_NAME="jellyfin"
CONFIG_VOLUME="jellyfin-config"
MEDIA_SOURCE="/workspaces/codespaces-blank"
BACKUP_DIR="/opt/drive_bkp"
CONFIG_BACKUP_FILE="jellyfin-config_backup.tar.gz"


# Step 1: Backup Jellyfin configuration
docker run --rm \
  --volumes-from $CONTAINER_NAME \
  -v $BACKUP_DIR:/backup \
  busybox \
  tar czf /backup/$CONFIG_BACKUP_FILE /config

echo "Jellyfin configuration backup created: $BACKUP_DIR/$CONFIG_BACKUP_FILE"

echo "Jellyfin configuration backup created: $BACKUP_DIR/$CONFIG_BACKUP_FILE"

echo "Jellyfin configuration backup created: $BACKUP_DIR/$CONFIG_BACKUP_FILE"

echo "Jellyfin configuration backup created: $BACKUP_DIR/$CONFIG_BACKUP_FILE"

echo "Jellyfin configuration backup created: $BACKUP_DIR/$CONFIG_BACKUP_FILE"

