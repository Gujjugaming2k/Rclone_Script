#!/bin/bash
sudo su - root
id
id
id
id

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

# Wait for 60 seconds
sleep 60
echo "copy zip..."
echo "copy zip..."
echo "copy zip..."

sudo cp /opt/drive_bkp/jellyfin_backup.zip /opt/jellyfin/
echo "extract zip..."
echo "extract zip..."
echo "extract zip..."
sudo unzip -o /opt/jellyfin/jellyfin_backup.zip -d /

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


curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiNTU0ZTc1MTQtMTZiMS00NGYzLWExN2QtYjMzYmE5MjRhYTg2IiwicyI6IlkySTVPV1ppTVRJdE5tRmpZeTAwWXpnd0xUbGpaRGt0WVdJeU1EZzNNMkUxTWpZeCJ9


nohup ./jellyfin.sh &
