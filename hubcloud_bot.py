import os
import asyncio
import aiohttp  # Asynchronous HTTP requests
import aiofiles
from bs4 import BeautifulSoup
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# 🔥 Replace with your bot token
TELEGRAM_BOT_TOKEN = "7556090644:AAHuRIPH1KqiRf0Ykd_Ert97cLedZWDr51I"

# 🔥 Telegram group ID for logs
TELEGRAM_GROUP_ID = "-1002661622618"  # Replace with your group ID

# 🔥 Current HubCloud domain (change when needed)
CURRENT_DOMAIN = "https://hubcloud.ink"

# 🔥 List of supported HubCloud domains
SUPPORTED_DOMAINS = [
    "https://hubcloud.lol",
    "https://hubcloud.ink",
    "https://hubcloud.dad",
    "https://hubcloud.art",
    "https://hubcloud.cc",
    "https://hubcloud.vip",
    "https://hubcloud.co",
    "https://hubcloud.net",
    "https://hubcloud.xyz"
]

SAVE_FOLDER = "/opt/jellyfin/STRM_BOT"  # Folder path to save .strm files

# Ensure save folder exists
if not os.path.exists(SAVE_FOLDER):
    os.makedirs(SAVE_FOLDER)

def normalize_url(url):
    """Convert all supported domains to the current domain."""
    for domain in SUPPORTED_DOMAINS:
        if url.startswith(domain):
            # Replace the domain with the current domain
            new_url = url.replace(domain, CURRENT_DOMAIN)
            return new_url
    return url  # Return original if no match

async def fetch_title(url):
    """Asynchronously fetch and clean the webpage title."""
    headers = {"User-Agent": "Mozilla/5.0"}

    async with aiohttp.ClientSession() as session:
        try:
            async with session.get(url, headers=headers, timeout=10) as response:
                if response.status == 200:
                    html = await response.text()
                    soup = BeautifulSoup(html, "html.parser")
                    title = soup.title.string.strip() if soup.title else "Unknown"
                    return title.replace("HubCloud | ", "")
        except Exception as e:
            print(f"Failed to extract title: {e}")
            return "Unknown"

async def create_strm_file(title, url):
    """Asynchronously create a .strm file with the extracted title."""
    filename = os.path.join(SAVE_FOLDER, f"{title}.strm")
    content = f"https://hub.vflix.life/redirect_video?base_url={url}"

    async with aiofiles.open(filename, "w") as file:
        await file.write(content)
    
    return filename

async def send_log_to_group(bot, title, filename):
    """Send the uploaded log message to the Telegram group."""
    message = f"✅ **Uploaded Successfully**\n🎥 Title: `{title}`"
    await bot.send_message(chat_id=TELEGRAM_GROUP_ID, text=message, parse_mode="Markdown")

# ✅ New /start handler
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Send a welcome message with instructions."""
    message = (
        "👋 **Welcome to the HubCloud Bot!**\n\n"
        "📌 **Usage:**\n"
        "Send a command in the format:\n"
        "`/hub <HubCloud URL>`\n\n"
        "✅ Example:\n"
        "`/hub https://hubcloud.ink/drive/xyz123`\n\n"
        "The bot will upload the file in VFlix Prime Server."
    )

    await update.message.reply_text(message, parse_mode="Markdown")

# ✅ Asynchronous handler with multi-user support
async def hub_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle /hub command and generate .strm files concurrently."""
    if len(context.args) == 0:
        usage_text = (
        "📌 **Usage:**\n"
        "Send a command in the format:\n"
        "`/hub <HubCloud URL>`\n\n"
        "✅ Example:\n"
        "`/hub https://hubcloud.ink/drive/xyz123`\n\n"
        "The bot will upload the file in VFlix Prime Server."
    )
        await update.message.reply_text(usage_text, parse_mode="Markdown")
        return

    url = context.args[0]

    # Normalize the URL to the current domain
    normalized_url = normalize_url(url)

    # Validate the domain after normalization
    if not normalized_url.startswith(f"{CURRENT_DOMAIN}/drive/"):
        await update.message.reply_text("❌ Invalid URL. Please provide a valid HubCloud link.")
        return

    # Fetch title and create .strm file concurrently
    title = await fetch_title(normalized_url)
    
    if title != "Unknown":
        filename = await create_strm_file(title, normalized_url)
        reply = (
        f"✅ **Uploaded Successfully**\n🎥 Title: `{title}`"
    )
        await update.message.reply_text(reply, parse_mode="Markdown")

        # ✅ Send log to Telegram group
        await send_log_to_group(context.bot, title, os.path.basename(filename))
        
    else:
        await update.message.reply_text("Failed to fetch the title. Please try again.")

def main():
    """Start the bot using polling."""
    app = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()

    # Use async handler
    app.add_handler(CommandHandler("start", start_command))
    app.add_handler(CommandHandler("hub", hub_command))

    print("Bot is running with multi-user support...")

    # Use polling
    app.run_polling()

if __name__ == "__main__":
    main()
