#!/bin/bash
sudo apt update
sudo su - root
id
id
id
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime


# Check if rclone is already installed
if ! command -v rclone &> /dev/null; then
    echo "Installing rclone..."
    curl https://rclone.org/install.sh | sudo bash
	sudo apt install fuse
else
    echo "rclone is already installed."
fi
