#!/bin/bash
sudo su - root
id
id
id
id

sudo mkdir /opt/jellyfin
cd /opt/jellyfin

sudo wget https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_10.9.7-amd64.tar.gz
sudo tar xvzf jellyfin_10.9.7-amd64.tar.gz

sudo mkdir data cache config log



sudo apt install ffmpeg -y

sudo bash -c 'cat << "EOF" > /opt/jellyfin/jellyfin.sh
#!/bin/bash
JELLYFINDIR="/opt/jellyfin"
FFMPEGDIR="/usr/share/jellyfin-ffmpeg"

$JELLYFINDIR/jellyfin/jellyfin \
 -d $JELLYFINDIR/data \
 -C $JELLYFINDIR/cache \
 -c $JELLYFINDIR/config \
 -l $JELLYFINDIR/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
EOF'
cd /opt/jellyfin
# Make the file executable
chmod +x jellyfin.sh
sudo chown -R user:group *
sudo chmod u+x jellyfin.sh



sudo curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiOGQ4NWZjODYtMGQwZC00MTFhLWE1Y2EtZjc1NDliZWZiNTQ4IiwicyI6Ik9UZ3hOV1EwTWprdE9HRTVaQzAwTVRFeUxXSmhZelF0WkdNMU9EVTRaR0V6WWpVMyJ9

sudo ./jellyfin.sh
