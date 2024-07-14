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

sudo git clone https://github.com/Gujjugaming2k/gofile-downloader.git
cd gofile-downloader
sudo pip3 install -r requirements.txt


GITHUB_FILE_URL="https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/link.txt"

# Fetch the data from the URL
url=$(curl -s $GITHUB_FILE_URL)

# Call the Python script with the fetched URL
python gofile-downloader.py "$url"


# Extract the identifier from the URL
dr=$(echo $url | awk -F '/' '{print $NF}')

cd $dr
cd $dr
ls -lhtr
cp jellyfin_backup.zip /opt/jellyfin/


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

/etc/init.d/cloudflared start

# Check the status of the cloudflared service
/etc/init.d/cloudflared status

sleep 5
# Capture the status result
STATUS=$?



# If the status is not running (status code not equal to 0), start the service
if [ $STATUS -ne 0 ]; then
    echo "Not running"
    echo "Starting the cloudflared service..."
    /etc/init.d/cloudflared start

    # Check if the service started successfully
    if [ $? -eq 0 ]; then
        echo "cloudflared service started successfully."
    else
        echo "Failed to start cloudflared service."
        
    fi
else
    echo "cloudflared service is running."
fi

./jellyfin.sh
