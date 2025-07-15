#!/bin/bash

# Wind Tunnel Demo Startup Script for Raspberry Pi
# This script starts the Flask backend and opens the browser in full screen

echo "🌪️  Starting Wind Tunnel Demo..."
echo "📊 Management Demo Mode"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BACKEND_DIR="$SCRIPT_DIR/backend"

# Function to check if Flask is running
check_flask() {
    curl -s http://localhost:5000/api/status > /dev/null 2>&1
    return $?
}

# Start Flask backend in background
echo "🚀 Starting Flask backend..."
cd "$BACKEND_DIR"
python3 app.py &
FLASK_PID=$!

# Wait for Flask to start
echo "⏳ Waiting for Flask to start..."
for i in {1..30}; do
    if check_flask; then
        echo "✅ Flask is running!"
        break
    fi
    sleep 1
done

# Check if Flask started successfully
if ! check_flask; then
    echo "❌ Flask failed to start"
    exit 1
fi

# Wait a bit more for full initialization
sleep 2

# Open browser in full screen (kiosk mode)
echo "🌐 Opening browser in full screen..."

# Set display if not already set
export DISPLAY=:0

# Try different browsers in order of preference for Raspberry Pi
if command -v chromium-browser &> /dev/null; then
    echo "Using Chromium browser"
    chromium-browser --kiosk --disable-infobars --disable-session-crashed-bubble --disable-restore-session-state --autoplay-policy=no-user-gesture-required --disable-features=VizDisplayCompositor http://localhost:5000 &
elif command -v firefox &> /dev/null; then
    echo "Using Firefox browser"
    firefox --kiosk http://localhost:5000 &
elif command -v google-chrome &> /dev/null; then
    echo "Using Google Chrome"
    google-chrome --kiosk --disable-infobars --disable-session-crashed-bubble --disable-restore-session-state --autoplay-policy=no-user-gesture-required http://localhost:5000 &
else
    echo "⚠️  No suitable browser found. Installing chromium-browser..."
    sudo apt update && sudo apt install chromium-browser -y
    if command -v chromium-browser &> /dev/null; then
        chromium-browser --kiosk --disable-infobars --disable-session-crashed-bubble --disable-restore-session-state --autoplay-policy=no-user-gesture-required --disable-features=VizDisplayCompositor http://localhost:5000 &
    else
        echo "🌐 Please manually open: http://localhost:5000"
    fi
fi

echo "🎯 Wind Tunnel Demo is now running!"
echo "📱 Access from other devices: http://$(hostname -I | awk '{print $1}'):5000"
echo "🔄 Press Ctrl+C to stop"

# Keep script running
wait $FLASK_PID
