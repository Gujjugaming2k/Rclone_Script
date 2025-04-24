import os
import re
import sys
import requests
import html  # For escaping special characters in the token

# Old domain and new domain
OLD_DOMAIN = "iosmirror.cc"
NEW_DOMAIN = "netfree2.cc/mobile"

# Function to update .strm files with the new token
def update_strm_links(base_folder, new_token):
    if not new_token:
        raise ValueError("New token is required")
    
    files_updated = []  # Track updated files
    skipped_count = 0   # Count skipped files
    updated_count = 0   # Count updated files

    for root, dirs, files in os.walk(base_folder):
        for file in files:
            if file.endswith(".strm"):
                file_path = os.path.join(root, file)

                # Read the file content
                with open(file_path, "r", encoding="utf-8") as f:
                    content = f.read().strip()

                updated = content
                changes_made = False

                # Print the original content (for debugging purposes)
                print(f"Processing file: {file_path}")
                print(f"Original content: {content}")

                # Replace domain
                if OLD_DOMAIN in updated:
                    updated = updated.replace(OLD_DOMAIN, NEW_DOMAIN)
                    changes_made = True
                    print(f"Domain replaced in: {file_path}")

                # Replace dynamic token using regex
                try:
                    updated, count = re.subn(
                        r'(in=)[^"&]+',  # Match `in=` followed by the token
                        f'in={new_token}',  # Replace with the new token directly
                        updated
                    )
                    if count > 0:
                        changes_made = True
                        print(f"Token replaced in: {file_path}")
                except re.error as e:
                    print(f"Regex error in file {file_path}: {e}")
                    continue  # Skip this file if there's a regex error

                # If changes were made, write the updated content back
                if changes_made:
                    with open(file_path, "w", encoding="utf-8") as f:
                        f.write(updated)
                    files_updated.append(file_path)  # Track updated file
                    updated_count += 1  # Increment updated count
                else:
                    skipped_count += 1  # Increment skipped count
    
    # Send a Telegram message summarizing the updates
    send_telegram_message(new_token, updated_count, skipped_count, files_updated)

# Function to send a Telegram message
def send_telegram_message(new_token, updated_count, skipped_count, files_updated):
    # Escape special characters in the token (optional)
    escaped_token = html.escape(new_token)
    message = (
        f"update_strm.py executed successfully.\n"
        f"New Token: {escaped_token}\n"
        f"Files Updated: {updated_count}\n"
        f"Files Skipped: {skipped_count}\n"
    )
    
    BOT_TOKEN = "6491244345:AAFKAeud7ZMwVnmXHQ_F-K__OTw9P_AtPyo"
    CHANNEL_ID = "-1002196503705"
    
    # Form the message string
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {
        "chat_id": CHANNEL_ID,
        "text": message,
        "parse_mode": "HTML"  # Use HTML to handle special characters
    }
    
    response = requests.post(url, data=payload)
    
    # Check the API response
    if response.status_code == 200:
        print("Message sent successfully!")
    else:
        print("Failed to send message. Error:", response.json())

# Main Execution
if __name__ == "__main__":
    # Get the new token passed as an argument
    if len(sys.argv) < 3:
        print("[❌] Usage: python update_strm.py <base_folder> <new_token>")
        sys.exit(1)

    # Extract parameters from command-line arguments
    base_folder = sys.argv[1].strip()
    new_token = sys.argv[2].strip()

    # Run the function
    update_strm_links(base_folder, new_token)
