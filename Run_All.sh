#!/bin/bash
sudo /etc/init.d/cloudflared stop
sudo /etc/init.d/cloudflared stop
sudo /etc/init.d/cloudflared stop
eval $(gh codespace env)
export BOT_TOKEN=$(gh codespace env get BOT_TOKEN)
export CHANNEL_ID=$(gh codespace env get CHANNEL_ID)

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="$CHANNEL_ID" \
    -d text="Started"

    
# Step 1: Run cron_config.sh
echo "Running cron_config.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/cron_config.sh | sudo bash



# Step 2: Run Jellyfin_Install.sh
echo "Running Jellyfin_Install.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Jellyfin_Install.sh | sudo bash

echo "Setup completed successfully."
