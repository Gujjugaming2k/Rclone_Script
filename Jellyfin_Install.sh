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


