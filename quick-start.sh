#!/bin/bash

# Quick Start - Professional Wind Tunnel Demo
# Run this script on the Pi to start everything

echo "🚀 Starting Professional Wind Tunnel Demo..."

# Go to project directory
cd ~/wind-tunnel-rpi-v3/wind-tunnel-demo

# Kill existing processes
pkill -f "python3.*app.py" 2>/dev/null
pkill chromium 2>/dev/null
sleep 2

# Start backend
echo "Starting backend..."
python3 backend/app.py &
sleep 3

# Start browser
echo "Starting browser..."
DISPLAY=:0 chromium-browser --kiosk --no-first-run --disable-infobars --disable-session-crashed-bubble --disable-web-security --allow-running-insecure-content --touch-events=enabled --enable-features=TouchpadAndWheelScrollLatching --disable-features=TouchpadAsyncPinchEvents http://localhost:5000 &

echo "✅ Demo started!"
echo "Touch the screen to interact with the professional wind tunnel interface"
