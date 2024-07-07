#!/bin/bash

# Step 1: Run cron_config.sh
echo "Running cron_config.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/cron_config.sh | sudo bash

# Step 2: Run rclone_script.sh
echo "Running rclone_script.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/rclone_script.sh | sudo bash

# Step 3-1: Run Rclone_Config.sh (assuming it should be run once)
echo "Running Rclone_Config.sh... 1 time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash

# Step 3-2: Run Rclone_Config.sh (assuming it should be run 2nd time)
echo "Running Rclone_Config.sh... 2nd time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash


# Step 4: Run Jellyfin_Install.sh
echo "Running Jellyfin_Install.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Jellyfin_Install.sh | sudo bash

echo "Setup completed successfully."
