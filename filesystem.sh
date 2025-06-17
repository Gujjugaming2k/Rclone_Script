#!/bin/bash

# Define the config file path
CONFIG_FILE="config.yaml"

# Write the required configuration to the file
sudo cat <<EOL > "$CONFIG_FILE"
server:
  port: 8021
  database: ./database.db
  sources:
  - path: /tmp/opt/jellyfin/
  logging:
  - levels: info|warning|error
    apiLevels: info|warning|error
    output: stdout
    noColors: false
    utc: false
frontend:
  name: FileBrowser Quantum
userDefaults:
  permissions:
    api: false
    admin: false
    modify: false
    share: false
    realtime: false
EOL

# Verify file creation
if [ -f "$CONFIG_FILE" ]; then
    echo "Configuration file '$CONFIG_FILE' created successfully."
else
    echo "Failed to create configuration file."
    exit 1
fi

# Download the FileBrowser binary
echo "Downloading FileBrowser..."
sudo wget https://github.com/gtsteffaniak/filebrowser/releases/download/v0.7.9-beta/linux-amd64-filebrowser

# Check if download was successful
if [ -f "linux-amd64-filebrowser" ]; then
    echo "FileBrowser downloaded successfully."
else
    echo "Failed to download FileBrowser."
    exit 1
fi

# Change permission to executable
sudo chmod 777 linux-amd64-filebrowser
echo "Permissions updated."

# Run FileBrowser in the background
echo "Starting FileBrowser in the background..."
sudo ./linux-amd64-filebrowser

# Inform the user
echo "FileBrowser is running in the background."
