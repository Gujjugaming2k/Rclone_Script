echo "Running rclone_script.sh..."
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/rclone_script.sh | sudo bash

# Step 3-1: Run Rclone_Config.sh (assuming it should be run once)
echo "Running Rclone_Config.sh... 1 time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash

# Step 3-2: Run Rclone_Config.sh (assuming it should be run 2nd time)
echo "Running Rclone_Config.sh... 2nd time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash

sudo mkdir /opt/jellyfin
cd /opt/jellyfin

sudo wget https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_10.9.7-amd64.tar.gz
sudo tar xvzf jellyfin_10.9.7-amd64.tar.gz


sudo bash -c 'cat << "EOF" > /opt/jellyfin/jellyfin.sh
#!/bin/bash
JELLYFINDIR="/opt/jellyfin"
FFMPEGDIR="/usr/bin/ffmpeg"

$JELLYFINDIR/jellyfin/jellyfin \
 -d /opt/drive_bkp/Jellyfin_2024/data \
 -C /opt/drive_bkp/Jellyfin_2024/cache \
 -c /opt/drive_bkp/Jellyfin_2024/config \
 -l /opt/drive_bkp/Jellyfin_2024/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
EOF'

cd /opt/jellyfin
# Make the file executable
sudo chmod +x jellyfin.sh
sudo chown -R user:group *
sudo chmod u+x jellyfin.sh

curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiYTNlNTVhZmYtNzk2Mi00Y2I4LTkwYWEtNzZjOTYwNzBhM2M5IiwicyI6Ik5qSTRZekZpTlRBdE1XUXpOUzAwTjJSaExXSTBNREF0WXpVek9ESmhOMlUxWmpVMSJ9

/etc/init.d/cloudflared start

./jellyfin.sh
