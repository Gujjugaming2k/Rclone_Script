import os
import asyncio
import aiohttp  # Asynchronous HTTP requests
import aiofiles
from bs4 import BeautifulSoup
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes
import re

SAVE_FOLDER = "/tmp/opt/jellyfin/STRM_Hub_Bot"  # Folder path to save .strm files

# 🔥 Replace with your bot token
TELEGRAM_BOT_TOKEN = "7556090644:AAHuRIPH1KqiRf0Ykd_Ert97cLedZWDr51I"

# 🔥 Telegram group ID for logs
TELEGRAM_GROUP_ID = "-1002661622618"  # Replace with your group ID

# 🔥 Current domains
HUBCLOUD_DOMAIN = "https://hubcloud.bz"
GDFLIX_DOMAIN = "https://new4.gdflix.dad"

# 🔥 Supported HubCloud and GDFlix domains
HUBCLOUD_DOMAINS = [
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

GDFLIX_DOMAINS = [
    "https://new1.gdflix.dad",
    "https://new2.gdflix.dad",
    "https://new3.gdflix.dad",
    "https://new4.gdflix.dad",
    "https://new5.gdflix.dad",
    "https://new6.gdflix.dad"
]

# Ensure save folder exists
if not os.path.exists(SAVE_FOLDER):
    os.makedirs(SAVE_FOLDER)

# ✅ Normalize HubCloud URLs
def normalize_hubcloud_url(url):
    """Convert all supported HubCloud domains to the current domain."""
    for domain in HUBCLOUD_DOMAINS:
        if url.startswith(domain):
            return url.replace(domain, HUBCLOUD_DOMAIN)
    return url  # Return original if no match

# ✅ Normalize GDFlix URLs
def normalize_gdflix_url(url):
    """Convert all supported GDFlix domains to the current domain."""
    for domain in GDFLIX_DOMAINS:
        if url.startswith(domain):
            return url.replace(domain, GDFLIX_DOMAIN)
    return url  # Return original if no match

# ✅ Validate GDFlix domain and URL structure
def validate_gdflix_url(url):
    """Check if the domain is valid and the URL structure matches."""
    # Check if the domain is valid
    valid_domain = any(url.startswith(domain) for domain in GDFLIX_DOMAINS)
    if not valid_domain:
        return False, "❌ Invalid GDFlix domain."

    # Check if the URL structure is valid
    pattern = re.compile(r"https:\/\/new\d+\.gdflix\.dad\/file\/[A-Za-z0-9]+")
    if not pattern.match(url):
        return False, "❌ Invalid GDFlix link format."

    return True, None

# ✅ Fetch title from URL
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
                    return title
        except Exception as e:
            print(f"Failed to extract title: {e}")
            return "Unknown"

# ✅ Create HubCloud .strm file
async def create_hub_strm_file(title, url):
    """Create .strm file for HubCloud."""
    filename = os.path.join(SAVE_FOLDER, f"{title}.strm")
    content = f"https://hub.vflix.life/redirect_video?base_url={url}"

    async with aiofiles.open(filename, "w") as file:
        await file.write(content)
    
    return filename

# ✅ Create GDFlix .strm file
async def create_gd_strm_file(title, url):
    """Create .strm file for GDFlix."""
    filename = os.path.join(SAVE_FOLDER, f"{title}.strm")
    content = f"https://gdflix.vflix.life/redirect_video?base_url={url}"

    async with aiofiles.open(filename, "w") as file:
        await file.write(content)
    
    return filename

# ✅ Send log to Telegram group
async def send_log_to_group(bot, title, filename):
    """Send the uploaded log message to the Telegram group."""
    message = f"✅ **Uploaded Successfully**\n🎥 Title: `{title}`"
    await bot.send_message(chat_id=TELEGRAM_GROUP_ID, text=message, parse_mode="Markdown")

# ✅ /start handler
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Send a welcome message with instructions."""
    message = (
        "👋 **Welcome to the HubCloud and GDFlix Bot!**\n\n"
        "📌 **Usage:**\n"
        "`/hub <HubCloud URL>` → Uploads HubCloud links\n"
        "`/gd <GDFlix URL>` → Uploads GDFlix links\n\n"
        "✅ Example:\n"
        "`/hub https://hubcloud.ink/drive/xyz123`\n"
        "`/gd https://new4.gdflix.dad/file/abc456`\n\n"
        "The bot will upload the file in VFlix Prime Server."
    )
    await update.message.reply_text(message, parse_mode="Markdown")

# ✅ /hub handler
async def hub_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle /hub command and generate .strm files concurrently."""
    if len(context.args) == 0:
        message = (
        "📌 **Usage:**\n"
        "`/hub <HubCloud URL>` → Uploads HubCloud links\n"
        "✅ Example:\n"
        "`/hub https://hubcloud.ink/drive/xyz123`\n"
        "The bot will upload the file in VFlix Prime Server."
        )
        await update.message.reply_text(message, parse_mode="Markdown")
        #await update.message.reply_text("❌ Please provide a valid HubCloud URL.")
        return

    url = context.args[0]

    # Normalize the URL
    normalized_url = normalize_hubcloud_url(url)

    # Validate domain
    if not normalized_url.startswith(f"{HUBCLOUD_DOMAIN}/drive/"):
        await update.message.reply_text("❌ Invalid HubCloud link.")
        return

    # Fetch title and create .strm file
    title = await fetch_title(normalized_url)

    if title == "Unknown":
        await update.message.reply_text("❌ Failed to fetch the title. Please try again.")
        return

    filename = await create_hub_strm_file(title, normalized_url)
    
    reply = (
        f"✅ **Uploaded Successfully**\n🎥 Title: `{title}`"
    )
    await update.message.reply_text(reply, parse_mode="Markdown")

    # ✅ Send log to Telegram group
    await send_log_to_group(context.bot, title, os.path.basename(filename))

# ✅ /gd handler with domain and structure validation
async def gd_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle /gd command with domain and URL structure validation."""
    if len(context.args) == 0:
        message = (
        "📌 **Usage:**\n"
        "`/gd <GDFlix URL>` → Uploads GDFlix links\n\n"
        "✅ Example:\n"
        "`/gd https://new4.gdflix.dad/file/abc456`\n\n"
        "The bot will upload the file in VFlix Prime Server."
        )
        await update.message.reply_text(message, parse_mode="Markdown")
        #await update.message.reply_text("❌ Please provide a valid GDFlix URL.")
        return

    url = context.args[0]

    # ✅ Validate GDFlix URL
    is_valid, error_message = validate_gdflix_url(url)
    if not is_valid:
        await update.message.reply_text(error_message)
        return

    # Modify the URL from `/file/` to `/xfile/`
    modified_url = url.replace("/file/", "/xfile/")

    # Fetch the title
    title = await fetch_title(modified_url)

    if title == "Unknown" or title == "GDFlix | Google Drive Files Sharing Platform":
        await update.message.reply_text("❌ Invalid GDFlix link. Please provide a valid link.")
        return

    # Remove "GDFlix | " from the title
    final_title = title.replace("GDFlix | ", "")

    # Create .strm file
    filename = await create_gd_strm_file(final_title, modified_url)
    
    reply = (
        f"✅ **Uploaded Successfully**\n🎥 Title: `{final_title}`"
    )
    await update.message.reply_text(reply, parse_mode="Markdown")

    # ✅ Send log to Telegram group
    await send_log_to_group(context.bot, final_title, os.path.basename(filename))

# ✅ Main bot loop
def main():
    app = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()

    app.add_handler(CommandHandler("start", start_command))
    app.add_handler(CommandHandler("hub", hub_command))
    app.add_handler(CommandHandler("gd", gd_command))

    print("Bot is running with domain and structure validation...")
    app.run_polling()

if __name__ == "__main__":
    main()
