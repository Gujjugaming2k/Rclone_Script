import os
import re
import sys

# Old domain and new domain
OLD_DOMAIN = "iosmirror.cc"
NEW_DOMAIN = "netfree2.cc/mobile"

# Function to update .strm files with the new token
def update_strm_links(base_folder="/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix/Series/", new_token=""):
    if not new_token:
        raise ValueError("New token is required")

    for root, dirs, files in os.walk(base_folder):
        for file in files:
            if file.endswith(".strm"):
                file_path = os.path.join(root, file)

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

                if changes_made:
                    with open(file_path, "w", encoding="utf-8") as f:
                        f.write(updated)
                    print(f"✅ Updated: {file_path}")
                else:
                    print(f"⏭ Skipped (no match): {file_path}")

# Main Execution
if __name__ == "__main__":
    # Get the new token passed as argument
    if len(sys.argv) < 2:
        print("[❌] New token is required as an argument.")
        sys.exit(1)
    
    new_token = sys.argv[1].strip()
    update_strm_links("STRM", new_token)
