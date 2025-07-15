#!/bin/bash

# Professional Wind Tunnel Demo - Start Script
# Dark Mode Version with Company Logo

echo "🏢 Professional Wind Tunnel Demo"
echo "==============================="
echo "Dark Mode | Company Branding | Touch Optimized"
echo ""

# Navigate to project directory
cd ~/wind-tunnel-rpi-v3/wind-tunnel-demo

# Kill any existing processes
echo "🔄 Stopping existing processes..."
pkill -f "python3.*app.py" 2>/dev/null || true
pkill chromium 2>/dev/null || true
sleep 2

# Start the Flask backend
echo "🚀 Starting backend server..."
python3 backend/app.py &
BACKEND_PID=$!
echo "Backend started with PID: $BACKEND_PID"

# Wait for backend to start
sleep 3

# Check if backend is running
if pgrep -f "python3.*app.py" > /dev/null; then
    echo "✅ Backend is running"
else
    echo "❌ Backend failed to start"
    exit 1
fi

# Start the browser in kiosk mode
echo "🌐 Starting browser in kiosk mode..."
DISPLAY=:0 chromium-browser \
    --kiosk \
    --no-first-run \
    --disable-infobars \
    --disable-session-crashed-bubble \
    --disable-web-security \
    --allow-running-insecure-content \
    --touch-events=enabled \
    --enable-features=TouchpadAndWheelScrollLatching \
    --disable-features=TouchpadAsyncPinchEvents \
    http://localhost:5000 &

BROWSER_PID=$!
echo "Browser started with PID: $BROWSER_PID"

echo ""
echo "🎯 Professional Wind Tunnel Demo is running!"
echo "✅ Dark mode theme active"
echo "✅ Company logo displayed"
echo "✅ Touch-optimized interface"
echo "✅ No-scroll responsive design"
echo ""
echo "Press Ctrl+C to stop all processes"

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping demo..."
    kill $BACKEND_PID 2>/dev/null || true
    kill $BROWSER_PID 2>/dev/null || true
    pkill -f "python3.*app.py" 2>/dev/null || true
    pkill chromium 2>/dev/null || true
    echo "✅ Demo stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Keep script running
wait
