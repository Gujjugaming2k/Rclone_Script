#!/bin/bash

# Check the status of the cloudflared service
status=$(sudo /etc/init.d/cloudflared status)

# Print the status
echo "$status"

# If the status is not Running, start the cloudflared service
if [[ "$status" != *"Running"* ]]; then
    echo "cloudflared is not running. Starting the service..."
    sudo /etc/init.d/cloudflared start
else
    echo "cloudflared is already running."
fi
