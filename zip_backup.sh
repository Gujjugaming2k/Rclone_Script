#!/bin/bash

sleep 13000

    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Backup Started."

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




sudo su - root
id
id
id
id
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."

sudo rm -rf /opt/jellyfin/jellyfin_backup.zip
sudo rm -rf /tmp/jellyfin_backup.zip
sudo rm -rf /opt/jellyfin/gofile-downloader
sudo rm -rf /opt/jellyfin/jellyfin_10.9.7-amd64.tar.gz



sudo zip -r /tmp/jellyfin_backup.zip /opt/jellyfin/*

 # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Backup Completed."

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



sleep 10
url="https://livehume.store/github/github_token_date.php?type=create"

# Get the output and response code using curl
response=$(curl -s -w "%{http_code}" "$url")
output=$(echo "$response" | sed '$ d')
http_code=$(echo "$response" | tail -n 1)

# Print the output and response code
echo "Output:"
echo "$output"
echo "HTTP Status Code: $http_code"



    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Codespace Created - $output"

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


cp -r /tmp/jellyfin_backup.zip /opt/Rclone_Drive/w1928440/Jellyfin_BKP/
