#!/bin/bash

# Quick Fix Script for Touchscreen Issues
# Run this script to apply all touchscreen fixes

echo "🔧 Quick Touchscreen Fix"
echo "======================"

# Make sure we're in the right directory
cd /home/matrix/wind-tunnel-rpi-v3 2>/dev/null || {
    echo "❌ Error: Please run from wind-tunnel-rpi-v3 directory"
    exit 1
}

# Stop any running processes
echo "🛑 Stopping running processes..."
pkill -f "python3.*app.py" 2>/dev/null || true
pkill -f "chromium" 2>/dev/null || true

# Apply advanced touchscreen fix
echo "🖱️  Applying advanced touchscreen fix..."
if [ -f "touchscreen-fix-advanced.sh" ]; then
    chmod +x touchscreen-fix-advanced.sh
    ./touchscreen-fix-advanced.sh
else
    echo "⚠️  Advanced fix not found, using basic fix..."
    if [ -f "touchscreen-setup.sh" ]; then
        chmod +x touchscreen-setup.sh
        ./touchscreen-setup.sh
    fi
fi

# Apply immediate runtime fixes
echo "⚡ Applying immediate runtime fixes..."

# Find and configure touchscreen devices
TOUCHSCREEN_DEVICES=$(xinput list 2>/dev/null | grep -i touch | grep -oP 'id=\K\d+')

if [ ! -z "$TOUCHSCREEN_DEVICES" ]; then
    for DEVICE_ID in $TOUCHSCREEN_DEVICES; do
        echo "Configuring device $DEVICE_ID..."
        
        # Disable tapping to prevent text selection
        xinput set-prop $DEVICE_ID "libinput Tapping Enabled" 0 2>/dev/null || true
        
        # Enable natural scrolling
        xinput set-prop $DEVICE_ID "libinput Natural Scrolling Enabled" 1 2>/dev/null || true
        
        # Set scroll method
        xinput set-prop $DEVICE_ID "libinput Scroll Method Enabled" 0, 0, 1 2>/dev/null || true
        
        echo "✅ Configured device $DEVICE_ID"
    done
else
    echo "⚠️  No touchscreen devices found (normal if using SSH)"
fi

echo ""
echo "✅ Quick fixes applied!"
echo "===================="
echo ""
echo "🔄 For full effect, please reboot:"
echo "   sudo reboot"
echo ""
echo "🚀 After reboot, start demo with:"
echo "   ./start-touchscreen-demo.sh"
echo ""
echo "🌐 Access at: http://192.168.0.117:5000"
echo ""
