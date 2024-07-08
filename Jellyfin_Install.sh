#!/bin/bash
sudo su - root
id
id
id
id



# Pull Jellyfin Docker image
echo "Pulling Jellyfin Docker image..."
echo "Pulling Jellyfin Docker image..."
echo "Pulling Jellyfin Docker image..."
echo "Pulling Jellyfin Docker image..."
echo "Pulling Jellyfin Docker image..."
echo "Pulling Jellyfin Docker image..."

docker pull jellyfin/jellyfin

# Run Jellyfin Docker container
echo "Starting Jellyfin Docker container..."
echo "Starting Jellyfin Docker container..."
echo "Starting Jellyfin Docker container..."
echo "Starting Jellyfin Docker container..."
echo "Starting Jellyfin Docker container..."
echo "Starting Jellyfin Docker container..."

docker run -d \
  --name jellyfin \
  --network host \
  -v jellyfin-config:/config \
  --mount type=bind,source=/workspaces/codespaces-blank,target=/media \
  jellyfin/jellyfin

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."

echo "Jellyfin Docker container started."


sudo curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiNWIzNDA1ZDEzZmJiNWE1M2I2ZjM5ZjU4M2YwZmYwNjEiLCJ0IjoiOGQ4NWZjODYtMGQwZC00MTFhLWE1Y2EtZjc1NDliZWZiNTQ4IiwicyI6Ik9UZ3hOV1EwTWprdE9HRTVaQzAwTVRFeUxXSmhZelF0WkdNMU9EVTRaR0V6WWpVMyJ9

