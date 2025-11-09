#!/bin/bash

# === Configuration ===
PORT=8096                                # Jellyfin default port
SLEEP_INTERVAL=300                       # 5 minutes
LOG_FILE="/tmp/status_jellyfin.txt"      # Log file path

ENCODED_TOKEN="MTExODY0NTYyNDpBQUZzNHBBd3NMRG9vOTVjWDZwUGU5cEQxb0w1QjFoaTlzNA=="
ENCODED_CHANNEL_ID="LTEwMDIxOTY1MDM3MDU="

# Decode credentials
BOT_TOKEN=$(echo "$ENCODED_TOKEN" | base64 --decode)
CHANNEL_ID=$(echo "$ENCODED_CHANNEL_ID" | base64 --decode)

# === Function: send Telegram alert ===
send_telegram() {
    local MESSAGE="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHANNEL_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode="Markdown" >/dev/null
}

# === Function: check Jellyfin status ===
check_jellyfin() {
    TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo "[$TIMESTAMP] ✅ Jellyfin is running on port $PORT." >> "$LOG_FILE"
    else
        echo "[$TIMESTAMP] ❌ Jellyfin is NOT running. Restarting..." >> "$LOG_FILE"

        # Try restarting Jellyfin
        rm -f /tmp/jellyfin_sh.txt && sudo /tmp/opt/jellyfin/jellyfin.sh > /tmp/jellyfin_sh.txt 2>&1 &

        # Wait a few seconds and recheck
        sleep 5
        if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
            echo "[$TIMESTAMP] 🔁 Jellyfin restarted successfully." >> "$LOG_FILE"
            send_telegram "⚙️ *Auto-Restart:* Jellyfin was *down* but has been *restarted successfully* at ${TIMESTAMP}."
        else
            echo "[$TIMESTAMP] 🚨 Failed to restart Jellyfin." >> "$LOG_FILE"
            send_telegram "🚨 *Alert:* Jellyfin is *NOT running* and *restart failed* at ${TIMESTAMP}."
        fi
    fi
}

# === Loop every 5 min ===
echo "[$(date)] 🚀 Starting Jellyfin monitor (port $PORT)... Logs → $LOG_FILE" >> "$LOG_FILE"

while true; do
    check_jellyfin
    sleep $SLEEP_INTERVAL
done
