#!/bin/bash

while true; do
    # Check the status of the cloudflared service
   

        echo "cloudflared is not running. Starting the service..."
        sudo /etc/init.d/cloudflared start
    

    # Wait for 15 minutes before checking again
    sleep 900
done
