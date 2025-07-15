#!/bin/bash

# Auto-update script for Raspberry Pi
# This script can be run as a cron job to automatically pull updates

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/tmp/wind-tunnel-auto-update.log"
PROJECT_DIR="/home/matrix/wind-tunnel-rpi-v3"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Check if project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
    log_message "ERROR: Project directory not found: $PROJECT_DIR"
    exit 1
fi

cd "$PROJECT_DIR"

# Check if there are updates available
log_message "Checking for updates..."
git fetch origin

# Check if local is behind remote
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
    log_message "Updates available, pulling changes..."
    
    # Stop any running demo
    pkill -f "python3.*app.py" 2>/dev/null
    
    # Pull updates
    if git pull origin main; then
        log_message "Successfully pulled updates"
        
        # Make scripts executable
        chmod +x *.sh 2>/dev/null || true
        
        # Update Python dependencies
        cd wind-tunnel-demo/backend
        pip3 install -r requirements.txt --upgrade --quiet
        cd ../..
        
        log_message "Auto-update completed successfully"
    else
        log_message "ERROR: Failed to pull updates"
        exit 1
    fi
else
    log_message "No updates available"
fi

# Optional: Restart the demo if it was running
# Uncomment the next lines if you want auto-restart
# if pgrep -f "python3.*app.py" > /dev/null; then
#     log_message "Restarting demo..."
#     cd wind-tunnel-demo/backend
#     python3 app.py &
#     log_message "Demo restarted"
# fi
