#!/bin/bash
sudo su - root
id
id
id
id



#all Pip library
sudo pip3 install jsonify
sudo pip3 install requests
sudo pip3 install flask
sudo pip3 install bs4
sudo pip uninstall Flask Jinja2 markupsafe -y
sudo pip install Flask



BOT_TOKEN="6059800321:AAGwA1GePrmkwfZNuXOjmiQJmoFkxeEU1Vk"
CHANNEL_ID="-1002196503705"
# Message to send
MESSAGE="Jellyfin - Installation Started"

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


echo "checking current folder"
pwd
cd 
sudo git clone https://github.com/Gujjugaming2k/FileStreamBot.git /opt/FileStreamBot



sleep 10
if [ ! -f "/opt/Rclone_Drive/w1928440/Jellyfin_BKP/val.txt" ]; then
    echo "env File does not exist. Exiting script."
      # Message to send
  MESSAGE="env File does not exist. Exiting script"

  # Send the message using curl
  curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
      -d chat_id="${CHANNEL_ID}" \
      -d text="${MESSAGE}" \
      -d parse_mode="Markdown"

  # Check if the message was sent successfully
  if [ $? -eq 0 ]; then
      echo "Message sent successfully!"
  else
      echo "Failed to send message."
  fi
    exit 1
fi

echo "File exists. Continuing..."


# Local backup path
val_file="/opt/Rclone_Drive/w1928440/Jellyfin_BKP/val.txt"
destination_val="/opt/FileStreamBot/val.txt"

# Function to copy and rename the backup file
copy_val_file() {
  echo "Copying backup file from $val_file..."

  # Message to send
  MESSAGE="Downloading from val env file"

  # Send the message using curl
  curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
      -d chat_id="${CHANNEL_ID}" \
      -d text="${MESSAGE}" \
      -d parse_mode="Markdown"

  # Check if the message was sent successfully
  if [ $? -eq 0 ]; then
      echo "Message sent successfully!"
  else
      echo "Failed to send message."
  fi

  # Copy and rename the file
  sudo cp "$val_file" "$destination_val"
  sudo mv "$destination_val" "/opt/FileStreamBot/.env"
}

# Start the process
copy_val_file



cd /opt/FileStreamBot/
sudo pip3 install -r /opt/FileStreamBot/requirements.txt
sudo pip3 install flask

sudo mkdir /tmp/opt
sudo mkdir /tmp/opt/jellyfin
rm /tmp/opt/jellyfin/FileStream_bot_output.log

nohup sudo python3 -m FileStream >> /tmp/opt/jellyfin/FileStream_bot_$(date +%Y%m%d_%H%M%S).log 2>&1 &




# Message to send
MESSAGE="FileStreamBot Started"

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


sleep 10






# Some initial commands
echo "Starting some initial tasks..."

echo "Starting some initial tasks..."


# Wait for 10 seconds
sleep 10
echo "copy zip..."
echo "copy zip..."
echo "copy zip..."



#sudo wget https://download.vflix.xyz/jellyfin_backup.zip -P /tmp/

#!/bin/bash

# Primary URL and local backup path
primary_url="https://download.vflix.life/jellyfin_backup.zip"
backup_file="/opt/Rclone_Drive/w1928440/Jellyfin_BKP/jellyfin_backup.zip"
backup_STRM_file="/opt/Rclone_Drive/w1928440/Jellyfin_BKP/STRM.zip"
destination="/tmp/jellyfin_backup.zip"
destination_STRM="/tmp/STRM.zip"
min_size=$((50 * 1024 * 1024))  # 8 GB in bytes

# Function to download the file from URL
download_file() {
  url=$1
  echo "Downloading from $url..."
  sudo wget $url -O $destination
}

# Function to copy the file from the backup path
copy_backup_file() {
  echo "Copying backup file from $backup_file..."





# Message to send
MESSAGE="Downloading from Rclone"
nohup curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/filesizecheck.sh | bash > /tmp/script.log 2>&1 &
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
  sudo cp $backup_file $destination
  sudo cp $backup_STRM_file $destination_STRM
}

# Check if the file size meets the minimum requirement
check_file_size() {
  file=$1
  actual_size=$(stat -c%s "$file" 2>/dev/null || echo 0)
  if [[ $actual_size -ge $min_size ]]; then
    return 0  # File size is acceptable
  else
    return 1  # File size is too small
  fi
}

# Retry download if file size is below 8 GB
retry_download() {
  url=$1
  attempts=3  # Number of retries

  for ((i=1; i<=attempts; i++)); do
    echo "Attempt $i of $attempts..."
    download_file $url
    if check_file_size $destination; then
      echo "File size is acceptable."
      return 0
    else
      echo "File size is smaller than 8 GB. Retrying..."
    fi
  done

  echo "Failed to download a valid file after $attempts attempts."
  return 1
}

# Start by checking the primary URL
if wget --spider $primary_url 2>/dev/null; then
  echo "Primary URL is available."
  
      # Replace with your bot token


# Message to send
MESSAGE="Downloading Primary URL"
nohup curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/filesizecheck.sh | bash > /tmp/script.log 2>&1 &
# Send the message using curl
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHANNEL_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"  # or "HTML" for HTML formatting

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "Message sent successfully!"
else
    echo "Failed to send a message."
fi

  if ! retry_download $primary_url; then
    echo "Downloading from the primary URL failed or the file size was too small."
    copy_backup_file
  fi
else
  echo "Primary URL is down. Copying backup file..."
  copy_backup_file
fi

# Check if the file was downloaded/copied successfully
if [[ -f "$destination" && $(stat -c%s "$destination") -ge $min_size ]]; then
  echo "File downloaded/copied successfully and meets the size requirement."
else
  echo "Failed to download/copy the file with the required size."
fi


# Get the file size
file_size=$(stat -c%s "/tmp/jellyfin_backup.zip")

# Convert the file size to a human-readable format
human_readable_size=$(du -h "/tmp/jellyfin_backup.zip" | cut -f1)

# Print the file size
echo "File size (in bytes): $file_size"
echo "File size (human-readable): $human_readable_size"







echo "extract zip..."
echo "extract zip..."
echo "extract zip..."
sudo unzip -o /tmp/jellyfin_backup.zip -d /
sudo unzip -o /tmp/STRM.zip -d /
sudo rm -rf /opt/jellyfin/jellyfin_backup.zip
#sudo rm -rf /tmp/jellyfin_backup.zip


#iostoken and strm update
sudo wget -O /tmp/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix/fetch_token_ios.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/fetch_token_ios.py
sudo wget -O /tmp/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix/update_strm.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/update_strm.py
nohup sudo python3 /tmp/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix/fetch_token_ios.py &

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
URIs: https://tor1.mirror.jellyfin.org/ubuntu
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


# Download the script
curl -O https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/cloudflared_status.sh

# Make the script executable
chmod +x cloudflared_status.sh

# Run the script in the background and redirect output to status_log.txt
./cloudflared_status.sh >> status_log.txt 2>&1 &

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


sudo apt-get update -y && sudo apt-get install curl apt-transport-https gnupg -y
curl https://apt.hrfee.dev/hrfee.pubkey.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.hrfee.dev.gpg
echo "deb https://apt.hrfee.dev trusty main" | sudo tee /etc/apt/sources.list.d/hrfee.list
sudo apt-get update -y
sudo apt-get install jfa-go -y




    # Replace with your bot token


# Message to send
MESSAGE="Cloudflare Started Starting Jellyfin, File size - $human_readable_size"

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


sudo wget https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_10.10.7-amd64.tar.gz
sudo tar xvzf jellyfin_10.10.7-amd64.tar.gz -C /tmp/opt/jellyfin/

rm -rf jellyfin_10.10.7-amd64.tar.gz

# Step 3-4: Run Rclone_Config.sh (assuming it should be run 4nd time)
echo "Running Rclone_Config.sh... 2nd time"
curl -sSL https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/main/Rclone_Config.sh | sudo bash


sudo bash -c 'cat << "EOF" > /tmp/opt/jellyfin/jellyfin.sh
#!/bin/bash
JELLYFINDIR="/tmp/opt/jellyfin"
FFMPEGDIR="/usr/share/jellyfin-ffmpeg"

$JELLYFINDIR/jellyfin/jellyfin \
 -d /tmp/opt/jellyfin/data \
 -C /tmp/opt/jellyfin/cache \
 -c /tmp/opt/jellyfin/config \
 -l /tmp/opt/jellyfin/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
EOF'




sudo wget -O /opt/Flaskhub.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/Flaskhub.py
nohup sudo python3 /opt/Flaskhub.py &


sudo wget -O /opt/Flaskgdflix.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/Flaskgdflix.py
nohup sudo python3 /opt/Flaskgdflix.py &


sudo wget -O /opt/FileStream_start_flask.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/FileStream_start_flask.py
nohup sudo python3 /opt/FileStream_start_flask.py &



sudo wget -O /opt/hubcloud_bot.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/hubcloud_bot.py
sudo pip3 install asyncio
sudo pip3 install aiohttp
sudo pip3 install aiofiles
sudo pip3 install python-telegram-bot
nohup sudo python3 /opt/hubcloud_bot.py &



sudo wget -O /opt/Telegram_jellyfin_usercreate.py https://raw.githubusercontent.com/Gujjugaming2k/Rclone_Script/refs/heads/main/Telegram_jellyfin_usercreate.py
nohup sudo python3 /opt/Telegram_jellyfin_usercreate.py &





sudo /etc/init.d/cloudflared start
sudo /etc/init.d/cloudflared start

sudo chmod 777 /tmp/opt/jellyfin/jellyfin.sh

sudo /etc/init.d/cloudflared start
sudo /etc/init.d/cloudflared start

sudo /tmp/opt/jellyfin/jellyfin.sh
