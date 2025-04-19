#!/bin/bash
    # Replace with your bot token
. /tmp/opt/jellyfin/Token/Telegram_token.txt

# Assign to new variables with quotes
BOT_TOKEN="$TOKEN"
CHANNEL_ID="$CHANNELID"

# Print to verify (also in quotes)
echo "BOT_TOKEN=\"$BOT_TOKEN\""
echo "CHANNEL_ID=\"$CHANNEL_ID\""

# Message to send
MESSAGE="Backup Script Placed"

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

sleep 7200


sleep 4860



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


sudo rm -rf /tmp/jellyfin_backup.zip

sudo su - root
id
id
id
id
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."

sudo rm -rf /tmp/opt/jellyfin/jellyfin_backup.zip
sudo rm -rf /tmp/jellyfin_backup.zip
sudo rm -rf /opt/jellyfin/gofile-downloader
sudo rm -rf /opt/jellyfin/jellyfin_10.9.7-amd64.tar.gz


sudo zip -r /opt/Rclone_Drive/w1928440/Jellyfin_BKP/STRM.zip /tmp/opt/jellyfin/STRM/
sudo zip -r /tmp/jellyfin_backup.zip /tmp/opt/jellyfin/*




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


# Set timezone to IST
export TZ='Asia/Kolkata'

current_time=$(date '+%I:%M:%S %p')
echo "Current Time: $current_time"

# Calculate next backup time (3.35 hours ahead) in 12-hour format
next_backup_time=$(date -d "+12060 seconds" '+%I:%M:%S %p')
echo "Next Backup Started Time: $next_backup_time"

# Calculate off time (4 hours ahead) in 12-hour format
off_time=$(date -d "+4 hours" '+%I:%M:%S %p')
echo "Off Time: $off_time"


msg="Current Time: $current_time --- Next Backup Time: $next_backup_time --- Off Time: $off_time"



# Message to send
MESSAGE="Next Details - $msg"

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








