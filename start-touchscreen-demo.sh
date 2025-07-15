#!/bin/bash

# Wind Tunnel Demo with Touchscreen Support
# This script starts the wind tunnel app with touch-optimized browser settings

echo "🌪️  Starting Wind Tunnel Demo with Touchscreen Support"
echo "====================================================="

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

# Function to start touch-optimized browser
start_browser() {
    echo "🌐 Starting touch-optimized browser..."
    
    # Get Pi IP address
    PI_IP=$(hostname -I | cut -d' ' -f1)
    URL="http://localhost:5000"
    
    # Touch-optimized browser flags
    TOUCH_FLAGS="--touch-events=enabled --enable-features=TouchpadOverscrollHistoryNavigation --enable-pinch --enable-viewport-meta --disable-features=TouchpadAndWheelScrollLatching --touch-adjustment --enable-smooth-scrolling"
    
    # Check if we're in desktop environment
    if [ -n "$DISPLAY" ]; then
        # Desktop environment - use Chromium
        if command -v chromium-browser &> /dev/null; then
            echo "Opening Chromium with touch support..."
            chromium-browser $TOUCH_FLAGS --start-fullscreen --app=$URL &
        elif command -v firefox &> /dev/null; then
            echo "Opening Firefox with touch support..."
            firefox --kiosk $URL &
        else
            echo "No suitable browser found. Install chromium-browser or firefox"
            echo "Manual access: $URL"
        fi
    else
        echo "No display detected. Access app at: $URL"
    fi
}

# Function to setup touchscreen
setup_touchscreen() {
    echo "🖱️  Configuring touchscreen..."
    
    # Run touchscreen setup if it exists
    if [ -f "./touchscreen-setup.sh" ]; then
        echo "Running touchscreen setup..."
        chmod +x touchscreen-setup.sh
        ./touchscreen-setup.sh
    fi
    
    # Apply runtime touch settings
    TOUCHSCREEN_ID=$(xinput list 2>/dev/null | grep -i touch | head -n1 | grep -oP 'id=\K\d+')
    
    if [ ! -z "$TOUCHSCREEN_ID" ]; then
        echo "Found touchscreen device ID: $TOUCHSCREEN_ID"
        
        # Enable natural scrolling
        xinput set-prop $TOUCHSCREEN_ID "libinput Natural Scrolling Enabled" 1 2>/dev/null || true
        
        # Enable horizontal scrolling
        xinput set-prop $TOUCHSCREEN_ID "libinput Horizontal Scroll Enabled" 1 2>/dev/null || true
        
        # Set scroll method to two-finger
        xinput set-prop $TOUCHSCREEN_ID "libinput Scroll Method Enabled" 0, 0, 1 2>/dev/null || true
        
        echo "✅ Touchscreen scrolling configured"
    else
        echo "⚠️  No touchscreen device found"
    fi
}

# Function to show access information
show_access_info() {
    PI_IP=$(hostname -I | cut -d' ' -f1)
    echo ""
    echo "🎯 Wind Tunnel Demo Access Information"
    echo "====================================="
    echo "Local Access:  http://localhost:5000"
    echo "Remote Access: http://$PI_IP:5000"
    echo ""
    echo "📱 Touch Features:"
    echo "• Finger scrolling enabled"
    echo "• Pinch-to-zoom support"
    echo "• Touch-optimized controls"
    echo "• Smooth scrolling"
    echo ""
    echo "🔧 Controls:"
    echo "• Tap to start/stop data collection"
    echo "• Swipe to scroll through data"
    echo "• Pinch to zoom charts"
    echo ""
}

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping Wind Tunnel Demo..."
    
    # Kill backend if running
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    
    # Kill any remaining python processes
    pkill -f "python3.*app.py" 2>/dev/null || true
    
    echo "✅ Demo stopped"
    exit 0
}

# Setup signal handlers
trap cleanup SIGINT SIGTERM

# Main execution
echo "🔧 Setting up touchscreen support..."
setup_touchscreen

echo "🚀 Starting Wind Tunnel Demo..."
start_backend

show_access_info

echo "🌐 Starting browser..."
start_browser

echo ""
echo "✅ Wind Tunnel Demo with Touchscreen Support is running!"
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
