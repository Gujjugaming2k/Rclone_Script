import os
import re
import sys
import requests

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

                # Replace domain
                if OLD_DOMAIN in updated:
                    updated = updated.replace(OLD_DOMAIN, NEW_DOMAIN)
                    changes_made = True

                # Replace dynamic token using regex
                updated, count = re.subn(
                    r'(in=)[^"&]+',
                    rf'\1{new_token}',
                    updated
                )
                if count > 0:
                    changes_made = True

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
        # Escape special characters (optional)
    import html
    escaped_token = html.escape(new_token)
    message = (
        f"update_strm.py executed successfully.\n"
        f"New Token: {escaped_token}\n"
        f"Files Updated: {updated_count}\n"
        f"Files Skipped: {skipped_count}\n"
    )
    
    BOT_TOKEN = "6808963452:AAHwB1p6MLfIpk-tioldZrLrJ5QWd2vVG60"
    CHANNEL_ID = "-1002196503705"
    #new_token = "da5cfa912a0ddd29e90092aebbdc7997::ffb1d1629b105d4999814c8887804327::1744857724::ni"
    

    
    # Form the message string
    #MESSAGE = f"update_strm.py executed successfully - New Token: {escaped_token}"
    
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
        print("[❌] Usage: python ts.py <base_folder> <new_token>")
        sys.exit(1)

    # Extract parameters from command-line arguments
    base_folder = sys.argv[1].strip()
    new_token = sys.argv[2].strip()

    # Run the function
    update_strm_links(base_folder, new_token)
