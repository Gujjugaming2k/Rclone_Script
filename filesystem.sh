#!/bin/bash

# Install File Browser
echo "Installing File Browser..."
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | sudo bash

# Initialize configuration
echo "Initializing configuration..."
sudo filebrowser config init

# Create admin user
echo "Adding admin user..."
sudo filebrowser users add admin1 VFlix1 --perm.admin

echo "✅ File Browser setup complete!"
