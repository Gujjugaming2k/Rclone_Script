#!/bin/bash

while true; do
    # Check the status of the cloudflared service
    status=$(sudo /etc/init.d/cloudflared status)

    # Print the status
    echo "$status"

    # If the status is not Running, start the cloudflared service
    if [[ "$status" != *"Running"* ]]; then


# Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Cloudflare not started starting"

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
        echo "cloudflared is not running. Starting the service..."
        sudo /etc/init.d/cloudflared start
    else
        echo "cloudflared is already running."
    fi

    # Wait for 15 minutes before checking again
    sleep 900
done
