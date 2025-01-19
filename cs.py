import os
import requests
from bs4 import BeautifulSoup
from telethon import TelegramClient, events
from telethon.tl.types import PeerChannel

# Replace with your API credentials
API_ID = '1365781'
API_HASH = 'be325d65730f050aa8e66ee844d68b4f'
BOT_TOKEN = '6491244345:AAEWUFD_DXlIusHkQjuiWdTPGGVZDkPooI4'
BIN_CHANNEL = -1002196503705  # Replace with your channel ID

# Create the Telegram client
client = TelegramClient('bot', API_ID, API_HASH).start(bot_token=BOT_TOKEN)
# Define the path where the .strm file should be saved
STRM_DIRECTORY = '/opt/jellyfin/STRM/m3u8/vidsrc_m3u8/'

#STRM_DIRECTORY = 'E:\\VFlix\\vidsrc.su\\STRM\\m3u8\\vidsrc_m3u8\\'

# Ensure the directory exists
if not os.path.exists(STRM_DIRECTORY):
    os.makedirs(STRM_DIRECTORY)

# Function to fetch the m3u8 URL and title
def fetch_m3u8_url_and_title(movie_id):
    m3u8_url = f"https://vidsrc.vflix.xyz/redirect_to_m3u8?url=https://vidsrc.su/embed/movie/{movie_id}"
    return m3u8_url

# Function to create the .strm file
def create_strm_file(movie_id):
    m3u8_url = fetch_m3u8_url_and_title(movie_id)

    # Fetch the title from the embed page
    url = f"https://simple-proxy.google-606.workers.dev/?destination=https://vidsrc.su/embed/movie/{movie_id}"
    response = requests.get(url)

    if response.status_code == 200:
        # Parse HTML to get the title
        soup = BeautifulSoup(response.text, 'html.parser')
        title_tag = soup.find('title')

        if title_tag:
            title = title_tag.text.strip()
            # Clean up the title to create a valid filename
            file_name = f"{title}"
            file_name = "".join(char for char in file_name if char.isalnum() or char in (" ", "-", "_"))
            file_name = file_name.replace(" ", "_")  # Optionally replace spaces with underscores

            # Make sure the file name ends with .strm
            if not file_name.endswith(".strm"):
                file_name += ".strm"

            # Define the full file path
            file_path = os.path.join(STRM_DIRECTORY, file_name)

            # Save the m3u8 URL to the .strm file in the specified directory
            with open(file_path, 'w') as file:
                file.write(m3u8_url)  # Write the m3u8 URL to the .strm file

            return f".strm file for movie '{title}' created successfully!"
        else:
            return f"Failed to fetch the title for movie ID {movie_id}. Please try again."
    else:
        return f"Failed to fetch the movie data for ID {movie_id}. Please try again."

# Handle messages and create .strm files based on movie ID
@client.on(events.NewMessage(pattern='/cs (\d+)'))
async def handle_create_strm(event):
    movie_id = event.pattern_match.group(1)
    
    if not movie_id.isdigit():  # Ensure it's a valid numeric ID
        await event.reply("Invalid movie ID. Please provide a numeric ID.")
        return

    response = create_strm_file(movie_id)
    await event.reply(response)

    # Optionally, send the .strm file to a channel
    strm_file_name = f"{movie_id}.strm"
    if os.path.exists(strm_file_name):
        await client.send_file(BIN_CHANNEL, strm_file_name, caption=f"Here is the .strm file for movie ID {movie_id}")

# Send a message to the channel when the bot starts
# Send a message to the channel when the bot starts
async def on_start():
    await client.send_message(BIN_CHANNEL, "Bot has started and is now ready to process movie IDs.")

# Start the client and send the startup message
client.loop.run_until_complete(on_start())

# Start the client
print("Bot is running...")
client.run_until_disconnected()
