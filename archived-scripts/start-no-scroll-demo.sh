#!/bin/bash

# No-Scroll Touchscreen Demo Launcher
# This script launches the wind tunnel demo optimized for touchscreen displays

echo "📱 No-Scroll Touchscreen Demo Launcher"
echo "====================================="

# Function to check if Python app is running
check_app_running() {
    if pgrep -f "python3.*app.py" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to start the backend
start_backend() {
    echo "🚀 Starting backend server..."
    cd wind-tunnel-demo/backend
    python3 app.py &
    BACKEND_PID=$!
    echo "Backend started with PID: $BACKEND_PID"
    
    # Wait for backend to start
    sleep 3
    
    # Check if backend is running
    if check_app_running; then
        echo "✅ Backend server is running"
    else
        echo "❌ Failed to start backend server"
        exit 1
    fi
}

# Function to start touchscreen-optimized browser
start_browser() {
    echo "🌐 Starting touchscreen-optimized browser..."
    
    # Get Pi IP address
    PI_IP=$(hostname -I | cut -d' ' -f1)
    URL="http://localhost:5000"
    
    # Touchscreen-optimized browser flags (no scrolling needed)
    BROWSER_FLAGS="--kiosk --touch-events=enabled --disable-scroll --disable-scrollbars --overscroll-behavior=none --disable-features=TranslateUI --disable-extensions --disable-plugins --disable-dev-shm-usage --no-sandbox --window-size=1024,768"
    
    # Check if we're in desktop environment
    if [ -n "$DISPLAY" ]; then
        # Desktop environment - use Chromium in kiosk mode
        if command -v chromium-browser &> /dev/null; then
            echo "Opening Chromium in kiosk mode (no scrolling)..."
            chromium-browser $BROWSER_FLAGS $URL &
        elif command -v firefox &> /dev/null; then
            echo "Opening Firefox in fullscreen mode..."
            firefox --kiosk $URL &
        else
            echo "No suitable browser found. Install chromium-browser or firefox"
            echo "Manual access: $URL"
        fi
    else
        echo "No display detected. Access app at: $URL"
    fi
}

# Function to show access information
show_access_info() {
    PI_IP=$(hostname -I | cut -d' ' -f1)
    echo ""
    echo "🎯 No-Scroll Demo Access Information"
    echo "==================================="
    echo "Local Access:  http://localhost:5000"
    echo "Remote Access: http://$PI_IP:5000"
    echo ""
    echo "📱 Touchscreen Features:"
    echo "• Entire app fits on screen (no scrolling needed)"
    echo "• Optimized for touchscreen displays"
    echo "• Responsive design for any screen size"
    echo "• Touch-friendly controls"
    echo ""
    echo "🔧 Display Features:"
    echo "• Full viewport utilization"
    echo "• Compact layout design"
    echo "• Real-time data visualization"
    echo "• Professional interface"
    echo ""
}

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping No-Scroll Demo..."
    
    # Kill backend if running
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    
    # Kill any remaining python processes
    pkill -f "python3.*app.py" 2>/dev/null || true
    
    # Kill browser processes
    pkill -f "chromium" 2>/dev/null || true
    pkill -f "firefox" 2>/dev/null || true
    
    echo "✅ Demo stopped"
    exit 0
}

# Setup signal handlers
trap cleanup SIGINT SIGTERM

# Main execution
echo "🚀 Starting No-Scroll Wind Tunnel Demo..."
start_backend

show_access_info

echo "🌐 Starting browser in kiosk mode..."
start_browser

echo ""
echo "✅ No-Scroll Demo is running!"
echo "=============================="
echo ""
echo "📱 The app is optimized to fit entirely on your screen"
echo "🖱️  No scrolling is required - everything is visible"
echo "🎯 Perfect for touchscreen displays"
echo ""
echo "Press Ctrl+C to stop the demo"
echo ""

# Keep script running
while true; do
    if ! check_app_running; then
        echo "❌ Backend stopped unexpectedly. Restarting..."
        start_backend
    fi
    sleep 10
done
