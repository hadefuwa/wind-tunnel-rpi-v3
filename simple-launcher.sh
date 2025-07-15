#!/bin/bash
# Simple desktop launcher with logging

LOG_FILE="/tmp/wind-tunnel-launcher.log"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    echo "$1"
}

# Clear previous log
> "$LOG_FILE"

log "🚀 Starting Wind Tunnel Demo Launcher"
log "📁 Working directory: $(pwd)"

# Navigate to home directory first
cd /home/matrix

log "📁 Home directory: $(pwd)"

# Check if project exists
if [ -d "wind-tunnel-rpi-v3" ]; then
    log "✅ Project directory found"
    cd wind-tunnel-rpi-v3
    
    # Check demo directory
    if [ -d "wind-tunnel-demo" ]; then
        log "✅ Demo directory found"
        cd wind-tunnel-demo
        
        # Check required files
        if [ -f "backend/app.py" ]; then
            log "✅ Backend app.py found"
        else
            log "❌ Backend app.py missing"
            exit 1
        fi
        
        if [ -f "frontend/index.html" ]; then
            log "✅ Frontend index.html found"
        else
            log "❌ Frontend index.html missing"
            exit 1
        fi
        
        # Kill existing processes
        log "🔄 Stopping existing processes"
        pkill -f "python3.*app.py" 2>/dev/null || true
        pkill chromium 2>/dev/null || true
        sleep 2
        
        # Start Flask backend
        log "🚀 Starting Flask backend"
        python3 backend/app.py >> "$LOG_FILE" 2>&1 &
        FLASK_PID=$!
        
        # Wait for Flask to start
        log "⏳ Waiting for Flask to start"
        sleep 5
        
        # Test Flask
        log "🧪 Testing Flask response"
        if curl -s http://localhost:5000 > /dev/null 2>&1; then
            log "✅ Flask is responding"
            
            # Start browser
            log "🌐 Starting browser"
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
                http://localhost:5000 >> "$LOG_FILE" 2>&1 &
            
            log "✅ Browser started"
            log "📋 Log file: $LOG_FILE"
        else
            log "❌ Flask is not responding"
            kill $FLASK_PID 2>/dev/null
            exit 1
        fi
        
    else
        log "❌ Demo directory missing"
        exit 1
    fi
else
    log "❌ Project directory missing"
    exit 1
fi

log "🏁 Launcher complete"
