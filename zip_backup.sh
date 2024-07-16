#!/bin/bash

sleep 13200


sudo su - root
id
id
id
id
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."
echo "Zipping the directory SOURCE_DIR to BACKUP_FILE..."

sudo rm -rf /opt/jellyfin/jellyfin_backup.zip
sudo rm -rf /opt/jellyfin/gofile-downloader
sudo rm -rf /opt/jellyfin/jellyfin_10.9.7-amd64.tar.gz



sudo zip -r /opt/jellyfin/jellyfin_backup.zip /opt/jellyfin/*




echo "Moving BACKUP_FILE to DEST_DIR..."
echo "Moving BACKUP_FILE to DEST_DIR..."
echo "Moving BACKUP_FILE to DEST_DIR..."
echo "Moving BACKUP_FILE to DEST_DIR..."
echo "Moving BACKUP_FILE to DEST_DIR..."


GITHUB_TOKEN="https://livehume.online/github/Gujju_G_Token.txt"

# Fetch the data from the URL
GITHUB_TOKEN=$(curl -s $GITHUB_TOKEN)

# Variables
REPO_OWNER="Gujjugaming2k"  # Replace with your GitHub username or organization
REPO_NAME="Rclone_Script"  # Replace with your repository name
BRANCH="main"  # Replace with your target branch
FILE_PATH="link.txt"

# Get the server to upload to
server_response=$(curl -s https://api.gofile.io/getServer)
server=$(echo $server_response | jq -r .data.server)
echo "Server: $server"

# File to upload
file_path="/opt/jellyfin/jellyfin_backup.zip"

# Upload the file with progress bar
upload_response=$(curl --progress-bar -F "file=@$file_path" https://$server.gofile.io/uploadFile)
download_url=$(echo $upload_response | jq -r .data.downloadPage)

# Print the download link
echo "Download link: $download_url"



# Create backupfile.sh with the download link only
echo "$download_url" > $FILE_PATH

# Make backupfile.sh executable
chmod +x $FILE_PATH

# Get the current commit SHA of the branch
latest_commit_sha=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/commits/$BRANCH" | jq -r '.sha')

# Get the current tree SHA of the branch
latest_tree_sha=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/trees/$latest_commit_sha" | jq -r '.sha')

# Create a new blob with the file content
blob_sha=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  -d @<(jq -n --arg content "$(cat $FILE_PATH | base64 -w 0)" '{"content": $content, "encoding": "base64"}') \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/blobs" | jq -r '.sha')

# Create a new tree with the new blob
new_tree_sha=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  -d @<(jq -n --arg path "$FILE_PATH" --arg sha "$blob_sha" --arg mode "100755" --arg type "blob" \
  '{"base_tree": "'$latest_tree_sha'", "tree": [{"path": $path, "mode": $mode, "type": $type, "sha": $sha}]}') \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/trees" | jq -r '.sha')

# Create a new commit with the new tree
new_commit_sha=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  -d @<(jq -n --arg message "Add backupfile.sh with download link" --arg tree "$new_tree_sha" --arg parent "$latest_commit_sha" \
  '{"message": $message, "tree": $tree, "parents": [$parent]}') \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/commits" | jq -r '.sha')

# Update the reference to point to the new commit
curl -s -X PATCH -H "Authorization: token $GITHUB_TOKEN" \
  -d @<(jq -n --arg sha "$new_commit_sha" '{"sha": $sha}') \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs/heads/$BRANCH"



      # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Backup successful: link uploaded on Github- $download_url"

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
url="https://livehume.online/github/github_token_date.php?type=create"

# Get the output and response code using curl
response=$(curl -s -w "%{http_code}" "$url")
output=$(echo "$response" | sed '$ d')
http_code=$(echo "$response" | tail -n 1)

# Print the output and response code
echo "Output:"
echo "$output"
echo "HTTP Status Code: $http_code"



    # Replace with your bot token
BOT_TOKEN="6491244345:AAH4yUO35M8Mf0jgKGwb5le4MLzXzSKxkWs"

# Replace with your channel ID or channel username
CHANNEL_ID="-1002196503705"

# Message to send
MESSAGE="Codespace Created - $output"

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
