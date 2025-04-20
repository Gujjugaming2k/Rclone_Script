import requests
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# === CONFIGURATION ===
JELLYFIN_URL = "https://jellyfin.vflix.life"  # Replace with your server URL
API_KEY = "f194e40abd604fb29ec2c401cfcd346e"  # Replace with your admin API key
AUTH_PROVIDER_ID = "DefaultAuthenticationProvider"
TELEGRAM_BOT_TOKEN = "7824471135:AAECqxTf4sThE-V8o6bviXnbGSjAIraN-l8"  # Replace with your bot token

# === HEADERS ===
HEADERS = {
    "X-Emby-Token": API_KEY,
    "Content-Type": "application/json"
}

# === JELLYFIN FUNCTIONS ===

def create_user(username, password):
    payload = {
        "Name": username,
        "Password": password
    }

    response = requests.post(f"{JELLYFIN_URL}/Users/New", headers=HEADERS, json=payload)

    if response.status_code == 200:
        user_id = response.json()["Id"]
        return user_id, f"[✅] User '{username}' created with ID: {user_id}"
    elif response.status_code == 409:
        user_id = get_user_id(username)
        return user_id, f"[ℹ️] User '{username}' already exists."
    else:
        return None, f"[❌] Failed to create user: {response.status_code} - {response.text}"

def get_user_id(username):
    response = requests.get(f"{JELLYFIN_URL}/Users", headers=HEADERS)
    if response.status_code == 200:
        for user in response.json():
            if user["Name"].lower() == username.lower():
                return user["Id"]
    return None

def configure_user_policy(user_id):
    policy = {
        "IsAdministrator": False,
        "IsHidden": True,
        "IsDisabled": False,
        "EnableAllFolders": True,
        "EnableRemoteAccess": True,
        "EnableLiveTvAccess": True,
        "EnableMediaPlayback": True,
        "EnableMediaDownloading": True,
        "EnablePlaybackRemuxing": False,
        "EnableAudioPlaybackTranscoding": False,
        "EnableVideoPlaybackTranscoding": False,
        "EnableVideoPlaybackConversion": False,
        "EnableContentDeletion": False,
        "EnablePublicSharing": False,
        "EnableSync": False,
        "EnableSubtitleDownloading": True,
        "EnableSyncTranscoding": False,
        "EnableSubtitleManagement": False,
        "EnableParentalControlManagement": False,
        "EnableRemoteControlOfOtherUsers": False,
        "EnableLiveTvManagement": False,
        "EnableLiveTvRecordingManagement": False,
        "EnableSharedDeviceControl": True,
        "EnableAllChannels": True,
        "EnableAllDevices": True,
        "EnableAllLibraries": True,
        "BlockedTags": [],
        "BlockedMediaFolders": [],
        "EnabledDevices": [],
        "EnableAudioPlaybackDownload": True,
        "EnableVideoPlaybackDownload": True,
        "AuthenticationProviderId": AUTH_PROVIDER_ID,
        "PasswordResetProviderId": AUTH_PROVIDER_ID,
        "MaxParentalRating": 10,
        "BlockedMediaTypes": [],
        "AccessSchedules": [],
        "BlockUnratedItems": [],
        "EnableUserPreferenceAccess": True
    }

    response = requests.post(f"{JELLYFIN_URL}/Users/{user_id}/Policy", headers=HEADERS, json=policy)
    return response.status_code in [200, 204]

# === TELEGRAM HANDLER ===

async def create(update: Update, context: ContextTypes.DEFAULT_TYPE):
    try:
        if len(context.args) != 2:
            await update.message.reply_text("❗ Usage: /create username password")
            return

        username = context.args[0]
        password = context.args[1]

        user_id, message = create_user(username, password)
        await update.message.reply_text(message)

        if user_id:
            success = configure_user_policy(user_id)
            if success:
                await update.message.reply_text(f"✅ Policy configured for user: {username}")
                await update.message.reply_text(f"🌐 {JELLYFIN_URL}\n👤 {username}\n🔑 {password}")
            else:
                await update.message.reply_text("⚠️ Failed to configure user policy.")
    except Exception as e:
        await update.message.reply_text(f"❌ Error: {str(e)}")

# === MAIN ===

def main():
    app = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()
    app.add_handler(CommandHandler("create", create))
    print("[🤖] Telegram bot is running...")
    app.run_polling()

if __name__ == "__main__":
    main()
