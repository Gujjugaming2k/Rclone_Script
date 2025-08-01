#!/bin/bash
    # Replace with your bot token
    #echo "BOT_TOKEN=\"$BOT_TOKEN\""


BOT_TOKEN="6059800321:AAGwA1GePrmkwfZNuXOjmiQJmoFkxeEU1Vk"
CHANNEL_ID="-1002196503705"
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



sleep 5
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

sleep 20m

# Message to send
MESSAGE="Codespace Stoped - $CODESPACE_NAME"

# Send the message using curl


#gh codespace stop -c $CODESPACE_NAME
 
