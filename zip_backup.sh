#!/bin/bash
    # Replace with your bot token
    #echo "BOT_TOKEN=\"$BOT_TOKEN\""


ENCODED_TOKEN="MTExODY0NTYyNDpBQUZzNHBBd3NMRG9vOTVjWDZwUGU5cEQxb0w1QjFoaTlzNA=="
ENCODED_CHANNEL_ID="LTEwMDIxOTY1MDM3MDU="
# Decode at runtime
BOT_TOKEN=$(echo "$ENCODED_TOKEN" | base64 --decode)
CHANNEL_ID=$(echo "$ENCODED_CHANNEL_ID" | base64 --decode)

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


# Current time in IST with AM/PM format
current_time=$(TZ='Asia/Kolkata' date +"%I:%M %p")
echo "🕒 Current Time (IST): $current_time"

# Calculate future time by adding 3h 20m 5s
future_time=$(TZ='Asia/Kolkata' date -d "$current_time +3 hours +20 minutes +5 seconds" +"%I:%M %p")
echo "🔜 Next Time After Sleep (IST): $future_time"

MESSAGE="🕒 Current Time : $current_time   🔜 Backup Will Start : $future_time"


# Send the message using curl
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHANNEL_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="HTML"  # or "HTML" for HTML formatting

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "Message sent successfully!"
else
    echo "Failed to send message."
fi
sleep 3h

#curl -O https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/Rclone_zip_Backup.sh
#chmod +x Rclone_zip_Backup.sh
#nohup ./Rclone_zip_Backup.sh &> Rclone_zip_Backup.log &





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


#Upload Stop Notification

# Base64-encoded values
ENCODED_TOKEN="ODQ4MzQ3NzA4ODpBQUVxUGlZQXdCelhWR2VCVm9WZmdWOHAzZnY5TWg5LW5mTQ=="
ENCODED_CHANNEL_ID="LTQ5NjY3Mzg4Mzc="

# Decode at runtime
BOT_TOKEN=$(echo "$ENCODED_TOKEN" | base64 --decode)
CHANNEL_ID=$(echo "$ENCODED_CHANNEL_ID" | base64 --decode)

# Message to send
MESSAGE="⛔ Stop Uploading ⛔"

# Send the message using curl
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHANNEL_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"

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

sudo rm -rf /tmp/opt/jellyfin/cache/

echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."

sudo rm -rf /tmp/opt/jellyfin/jellyfin_backup.zip
sudo rm -rf /tmp/jellyfin_backup.zip
sudo rm -rf /opt/jellyfin/gofile-downloader
sudo rm -rf /opt/jellyfin/jellyfin_10.9.7-amd64.tar.gz

# Delete jfago old logs

# Directory containing .vlog files
TARGET_DIR="/tmp/opt/jellyfin/STRM/jfago/data/db"

# Age threshold in days
AGE_DAYS=3

# Find and delete .vlog files older than AGE_DAYS
find "$TARGET_DIR" -type f -name "*.vlog" -mtime +$AGE_DAYS -print -exec rm -f {} \;

echo "Old .vlog files older than $AGE_DAYS days have been deleted from $TARGET_DIR."


sudo zip -r /opt/Rclone_Drive/w1928440/Jellyfin_BKP/STRM.zip /tmp/opt/jellyfin/STRM/

#sudo zip -r /tmp/jellyfin_backup.zip /tmp/opt/jellyfin/
sudo zip -0 -r /tmp/jellyfin_backup.zip /tmp/opt/jellyfin/

DATE=$(date +%Y%m%d_%H%M%S)
sudo zip -j /opt/Rclone_Drive/w1928440/Jellyfin_BKP/DB_Backup/Jellyfin_DB_Backup_$DATE.zip /tmp/opt/jellyfin/data/data/library.db /tmp/opt/jellyfin/data/data/jellyfin.db


ENCODED_TOKEN="MTExODY0NTYyNDpBQUZzNHBBd3NMRG9vOTVjWDZwUGU5cEQxb0w1QjFoaTlzNA=="
ENCODED_CHANNEL_ID="LTEwMDIxOTY1MDM3MDU="
# Decode at runtime
BOT_TOKEN=$(echo "$ENCODED_TOKEN" | base64 --decode)
CHANNEL_ID=$(echo "$ENCODED_CHANNEL_ID" | base64 --decode)

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



sleep 5
nohup sudo cp /tmp/jellyfin_backup.zip /opt/Rclone_Drive/w1928440/Jellyfin_BKP/ >/dev/null 2>&1 &

url="https://vflix.fun/github/github_token_date_v_1.php?type=create"

while true; do
  # Get the output and response code using curl
  response=$(curl -s -w "%{http_code}" "$url")
  output=$(echo "$response" | sed '$ d')
  http_code=$(echo "$response" | tail -n 1)

  # Print the output and response code
  echo "Output:"
  echo "$output"
  echo "HTTP Status Code: $http_code"

  # Check if status is 200
  if [ "$http_code" -eq 200 ]; then
    echo "✅ Success! Exiting loop."
    break
  else
    echo "⚠️ Request failed (code: $http_code). Retrying in 5 seconds..."
    sleep 10
  fi
done




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

sleep 20m

# Message to send
MESSAGE="Codespace Stoped - $CODESPACE_NAME"

# Send the message using curl


#gh codespace stop -c $CODESPACE_NAME
 
