#!/bin/bash

# Step 1: Run cron_config.sh
echo "Running cron_config.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/cron_config.sh | sudo bash



# Step 2: Run Jellyfin_Install.sh
echo "Running Jellyfin_Install.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Jellyfin_Install.sh | sudo bash

echo "Setup completed successfully."
