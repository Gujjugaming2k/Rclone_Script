#!/bin/bash
sudo su - root
id
id
id
id
# Create rclone configuration file
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
echo "Creating rclone configuration file..."
sudo touch /root/.config/rclone/rclone.conf
sudo cat <<EOF > /root/.config/rclone/rclone.conf
[w1928440]
type = drive
scope = drive
token = {"access_token":"ya29.a0AXooCgvBuHaABrOcOFd6XPc7_Jobu7gxIuEclzVoEAjYegVzBlJhuZOdbkQsCba-r2hsrYYELTRl9k1JiC7XJD2zzrmOqO3xWu7t3ne4pbS7uOXsj_4CuTHL0_Zzk3vIJyynmlbHoO71uHJMAcYHi-vFodDsB92N5aD_aCgYKAfgSARESFQHGX2MilerpDwLXbqWI5ph4oidGMg0171","token_type":"Bearer","refresh_token":"1//0gkoI7p7FtaZjCgYIARAAGBASNwF-L9IrrGIqlVBs3630G3I-oUQ7Ic6LyCh152g6USjw7aYnFRdS4q8N-ClGktC3tE85TILngEU","expiry":"2024-07-04T23:03:40.7952531+05:30"}
team_drive = 
EOF

# Replace remote with your w1928440 name, and fill in the appropriate client_id, client_secret, access_token, refresh_token, and expiry.


echo "Creating folder ..."
echo "Creating folder ..."
echo "Creating folder ..."
echo "Creating folder ..."
echo "Creating folder ..."
echo "Creating folder ..."
echo "Creating folder ..."
# Create a folder for mounting
sudo mkdir -p /opt/Rclone_Drive/w1928440/

# Mount the remote drive using rclone
echo "Mounting remote drive..."
echo "Mounting remote drive..."
echo "Mounting remote drive..."
echo "Mounting remote drive..."
echo "Mounting remote drive..."
echo "Mounting remote drive..."
sudo rclone mount w1928440: /opt/Rclone_Drive/w1928440 --vfs-cache-mode writes --allow-non-empty &

# Add any additional options or flags as needed for your use case.


