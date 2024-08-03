#!/bin/bash
sudo su - root
id
id
id
id

sudo git clone https://github.com/VFLIXPRIME/FileStreamBot_New.git
cd FileStreamBot_New

sudo pip3 install -r requirements.txt
nohup sudo python3 -m FileStream &

sleep 10
sudo mkdir /opt/jellyfin
cd /opt/jellyfin



# Some initial commands
echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

echo "Starting some initial tasks..."

# Wait for 10 seconds
sleep 10
echo "copy zip..."
echo "copy zip..."
echo "copy zip..."



sudo wget https://download.vflix.xyz/jellyfin_backup.zip -P /tmp/







echo "extract zip..."
echo "extract zip..."
echo "extract zip..."
sudo unzip -o /tmp/jellyfin_backup.zip -d /
sudo rm -rf /opt/jellyfin/jellyfin_backup.zip
sudo rm -rf /tmp/jellyfin_backup.zip

nohup sudo python3 -m http.server 9012 -d /tmp/ &


# Pull Jellyfin Docker image
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."
echo "Restoren Docker image..."
echo "Restore Docker image..."
echo "Restore Docker image..."



sudo apt install curl gnupg -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.jellyfin.org/jellyfin_team.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/jellyfin.gpg

export VERSION_OS="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
export VERSION_CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
export DPKG_ARCHITECTURE="$( dpkg --print-architecture )"
cat <<EOF | sudo tee /etc/apt/sources.list.d/jellyfin.sources
Types: deb
URIs: https://repo.jellyfin.org/${VERSION_OS}
Suites: ${VERSION_CODENAME}
Components: main
Architectures: ${DPKG_ARCHITECTURE}
Signed-By: /etc/apt/keyrings/jellyfin.gpg
EOF

sudo apt update -y
sudo apt install jellyfin -y

sudo /etc/init.d/cloudflared start

# Check the status of the cloudflared service
sudo /etc/init.d/cloudflared status

sleep 5
# Capture the status result
STATUS=$?



# If the status is not running (status code not equal to 0), start the service
if [ $STATUS -ne 0 ]; then
    echo "Not running"
    echo "Starting the cloudflared service..."
   sudo /etc/init.d/cloudflared start

    # Check if the service started successfully
    if [ $? -eq 0 ]; then
        echo "cloudflared service started successfully."
    else
        echo "Failed to start cloudflared service."
        
    fi
else
    echo "cloudflared service is running."
fi
sudo /etc/init.d/cloudflared start
sudo /etc/init.d/cloudflared start
sudo /etc/init.d/cloudflared start
sudo /etc/init.d/cloudflared start




    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Cloudflare Started Starting Jellyfin"

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
sudo /opt/jellyfin/jellyfin.sh
