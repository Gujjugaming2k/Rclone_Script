#!/bin/bash

# Define source and destination paths
SOURCE_PATH="/tmp/jellyfin_backup.zip"
DESTINATION_PATH="/opt/Rclone_Drive/w1928440/Jellyfin_BKP/jellyfin_backup.zip"
BACKUP_FOLDER="/opt/Rclone_Drive/w1928440/Jellyfin_BKP/backups"

# Create backup folder if it doesn't exist
mkdir -p "$BACKUP_FOLDER"

# Function to create a backup with a timestamp
create_backup() {
    TIMESTAMP=$(date +"%d_%m_%y_%I_%M_%p")
    BACKUP_FILE="jellyfin_backup_${TIMESTAMP}.zip"
    cp "$DESTINATION_PATH" "$BACKUP_FOLDER/$BACKUP_FILE"
    echo "Backup created: $BACKUP_FOLDER/$BACKUP_FILE"
BOT_TOKEN="6808963452:AAHwB1p6MLfIpk-tioldZrLrJ5QWd2vVG60"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Rclone Backup created: $BACKUP_FOLDER/$BACKUP_FILE"

# Send the message using curl
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHANNEL_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"  # or "HTML" for HTML formatting

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "Message sent successfully!"
else
    echo "Failed to send message."
fi
}

# Function to keep only the last 10 days of backups
cleanup_old_backups() {
    find "$BACKUP_FOLDER" -type f -mtime +10 -name "jellyfin_backup_*.zip" -exec rm -f {} \;
    echo "Old backups cleaned up."
}

# Function to copy the file and verify size
copy_with_retry() {
    local RETRIES=3
    for ((i=1; i<=RETRIES; i++)); do
        cp "$SOURCE_PATH" "$DESTINATION_PATH"
        SOURCE_SIZE=$(stat -c%s "$SOURCE_PATH")
        DEST_SIZE=$(stat -c%s "$DESTINATION_PATH")

        if [[ "$SOURCE_SIZE" -eq "$DEST_SIZE" ]]; then
            echo "File copied successfully and sizes match."
			
			BOT_TOKEN="6808963452:AAHwB1p6MLfIpk-tioldZrLrJ5QWd2vVG60"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Rclone File copied successfully"

# Send the message using curl
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHANNEL_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"  # or "HTML" for HTML formatting

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "Message sent successfully!"
else
    echo "Failed to send message."
fi

            return 0
        else
            echo "File sizes do not match, retrying... ($i/$RETRIES)"
        fi
    done

    echo "Failed to copy the file with matching size after $RETRIES attempts."
    return 1
}

# If the destination file exists, create a backup before overwriting
if [[ -f "$DESTINATION_PATH" ]]; then
    create_backup
fi

# Attempt to copy the file with retries
if copy_with_retry; then
    cleanup_old_backups
else
    echo "Error: File copy failed after multiple attempts."
    exit 1
fi
