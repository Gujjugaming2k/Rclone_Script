#!/bin/bash

# Switch to root user
sudo su - root

# Print the current user ID
id

# Define source and destination paths
SOURCE_DIR="/opt/jellyfin/"
BACKUP_FILE="/opt/jellyfin/jellyfin_backup.zip"
DEST_DIR="/opt/drive_bkp/"

# Print messages indicating the start of the backup process
echo "Zipping the directory $SOURCE_DIR to $BACKUP_FILE..."

# Create a zip file of the source directory
sudo zip -r "$BACKUP_FILE" "$SOURCE_DIR"

# Print messages indicating the start of the move process
echo "Moving $BACKUP_FILE to $DEST_DIR..."

# Move the backup file to the destination directory
sudo mv "$BACKUP_FILE" "$DEST_DIR"

# Check if the backup file exists in the destination directory
if [ -e "$DEST_DIR$(basename $BACKUP_FILE)" ]; then
    echo "Backup successful: $(basename $BACKUP_FILE) has been moved to $DEST_DIR"


    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Backup successful: $(basename $BACKUP_FILE) has been moved to $DEST_DIR"

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
else
    echo "Backup failed: $(basename $BACKUP_FILE) could not be found in $DEST_DIR"



    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Backup failed: $(basename $BACKUP_FILE) could not be found in $DEST_DIR"

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
fi
