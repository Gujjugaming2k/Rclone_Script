import requests
from bs4 import BeautifulSoup
import time
import re
import json
import subprocess

def get_cookie(base_url: str) -> str:
    session = requests.Session()

    # Step 1: Get /home and extract data-addhash
    home_resp = session.get(f"{base_url}/home")
    soup = BeautifulSoup(home_resp.text, "html.parser")
    addhash = soup.select_one("body").get("data-addhash")

    if not addhash:
        raise ValueError("data-addhash not found")

    print(f"[+] addhash: {addhash}")

    # Step 2: Trigger verification
    verify_url = f"https://userverify.netmirror.app/?fr3={addhash}&a=y"
    session.get(verify_url)

    # Step 3: POST to verify2.php until statusup = All Done
    verify2_url = f"{base_url}/verify2.php"
    while True:
        response = session.post(verify2_url, data={"verify": addhash})
        body = response.text
        print(f"[>] Waiting for verification...")  # Not printing full body to keep it clean
        if '"statusup":"All Done"' in body:
            break
        time.sleep(1)

    # Step 4: Get cookie from response headers
    set_cookie = response.headers.get("Set-Cookie")
    if not set_cookie:
        raise ValueError("Set-Cookie header not found")

    print(f"[+] Bypass cookie acquired.")
    return set_cookie

def fetch_playlist():
    base_url = "https://netfree2.cc/mobile"
    bypass_cookie = get_cookie(base_url)

    playlist_url = "https://netfree2.cc/mobile/playlist.php?id=786786&t=Sikandar&tm=1744815394"
    headers = {
        "Cookie": f"ott=nf; hd=on; {bypass_cookie}",
        "User-Agent": "Mozilla/5.0"
    }

    response = requests.get(playlist_url, headers=headers)
    response.raise_for_status()

    print("[✅] Playlist content fetched:\n")
    print(response.text)

    # Parse JSON and extract "in" param
    try:
        playlist_data = json.loads(response.text)
        first_source_file = playlist_data[0]["sources"][0]["file"]
        match = re.search(r'in=([^"&]+)', first_source_file)
        if match:
            in_token = match.group(1)
            print(f"[🎯] Extracted 'in' parameter: {in_token}")
            return in_token  # Return the token
        else:
            print("[❌] 'in' parameter not found in file URL.")
            return None
    except Exception as e:
        print(f"[❌] Failed to parse response: {e}")
        return None

def run_update_strm_script(new_token):
    try:
        # Call the update_strm.py script with the new token as argument
        subprocess.run(['python', '/tmp/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix/update_strm.py', '/tmp/opt/jellyfin/STRM/m3u8/IOSMIRROR/Netflix',new_token], check=True)
        print("[✅] update_strm.py executed successfully.")
            # Replace with your bot token
        
        # Assign to new variables (with quotes)
        BOT_TOKEN = "6491244345:AAFKAeud7ZMwVnmXHQ_F-K__OTw9P_AtPyo"  # Replace with your actual bot token
        CHANNEL_ID = "-1002196503705"  # Replace with your actual channel ID

        # Print to verify (also in quotes)
        print(f'BOT_TOKEN="{BOT_TOKEN}"')
        print(f'CHANNEL_ID="{CHANNEL_ID}"')

        
        # Message to send
        MESSAGE = f"update_strm.py executed successfully - New Token: {new_token}"
        
        # Send the message using requests
        url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
        payload = {
            "chat_id": CHANNEL_ID,
            "text": MESSAGE,
            "parse_mode": "Markdown"  # or "HTML" for HTML formatting
        }
        
        response = requests.post(url, data=payload)
        
        # Check if the message was sent successfully
        if response.status_code == 200:
            print("Message sent successfully!")
        else:
            print("Failed to send message.")
    except subprocess.CalledProcessError as e:
        print(f"[❌] Error running update_strm.py: {e}")

# Run it
if __name__ == "__main__":
    in_token = fetch_playlist()
    if in_token:
        print(f"[🎯] New token fetched: {in_token}")
        run_update_strm_script(in_token)
    else:
        print("[❌] Failed to fetch token.")
