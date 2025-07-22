#!/bin/bash
sleep 10
# Configuration
FILE="/tmp/jellyfin_backup.zip"
BOT_TOKEN="6059800321:AAGwA1GePrmkwfZNuXOjmiQJmoFkxeEU1Vk"
CHANNEL_ID="-1002196503705"
MSG_ID_FILE="/tmp/telegram_msg_id.txt"
RETRY_COUNT=0
MAX_RETRIES=3
CHECK_INTERVAL=15  # Time in seconds

# Function to get the file size in MB
get_file_size() {
    if [ -f "$FILE" ]; then
        stat -c%s "$FILE" 2>/dev/null | awk '{print int($1 / 1024 / 1024)}'
    else
        echo "0"
    fi
}

# Function to send the initial Telegram message
send_initial_message() {
    SIZE=$(get_file_size)
    MESSAGE="Monitoring download... Current size: ${SIZE} MB"

    response=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHANNEL_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode="Markdown")

    message_id=$(echo "$response" | jq -r '.result.message_id')
    echo "$message_id" > "$MSG_ID_FILE"
}

# Function to update the Telegram message with the latest file size
update_message() {
    message_id=$(cat "$MSG_ID_FILE")
    SIZE=$(get_file_size)
    CUR_SIZE=$(get_file_size)
    CURRENT_TIME=$(date +%s)

    DIFF_SIZE=$(( CUR_SIZE - PREV_SIZE ))
    TIME_DIFF=$(( CURRENT_TIME - PREV_TIME ))
    SPEED=$(awk "BEGIN {printf \"%.2f\", $DIFF_SIZE / $TIME_DIFF}")
    NEW_MESSAGE="Monitoring download... Current size: ${CUR_SIZE} MB and Speed: ${SPEED} MB/s"


    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/editMessageText" \
        -d chat_id="${CHANNEL_ID}" \
        -d message_id="${message_id}" \
        -d text="${NEW_MESSAGE}" \
        -d parse_mode="Markdown"
}

# Start by sending the initial message
send_initial_message

PREV_SIZE=$(get_file_size)

# Check file size every 15 seconds and update message
while true; do
    sleep "$CHECK_INTERVAL"
    CUR_SIZE=$(get_file_size)

    if [ "$CUR_SIZE" -eq "$PREV_SIZE" ]; then
        ((RETRY_COUNT++))
        echo "Size unchanged, retry attempt $RETRY_COUNT/$MAX_RETRIES"
    else
        RETRY_COUNT=0  # Reset retry count if size changes
    fi

    update_message
    PREV_SIZE=$CUR_SIZE

    if [ "$RETRY_COUNT" -ge "$MAX_RETRIES" ]; then
        FINAL_MSG="Download completed. Final file size: ${CUR_SIZE} MB"
        curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/editMessageText" \
            -d chat_id="${CHANNEL_ID}" \
            -d message_id="$(cat $MSG_ID_FILE)" \
            -d text="$FINAL_MSG" \
            -d parse_mode="Markdown"
        echo "Download complete. Exiting..."
        exit 0
    fi
done
