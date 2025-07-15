#!/bin/bash

# Touchscreen Diagnostic Script
# Use this to troubleshoot touchscreen scrolling issues

echo "🔍 Touchscreen Diagnostic Tool"
echo "============================="

echo ""
echo "1. 📱 Checking touchscreen devices..."
echo "-----------------------------------"
xinput list | grep -i touch

echo ""
echo "2. 🖱️  Input device properties..."
echo "--------------------------------"
TOUCHSCREEN_ID=$(xinput list | grep -i touch | head -n1 | grep -oP 'id=\K\d+')
if [ ! -z "$TOUCHSCREEN_ID" ]; then
    echo "Found touchscreen device ID: $TOUCHSCREEN_ID"
    xinput list-props $TOUCHSCREEN_ID | grep -i scroll
else
    echo "❌ No touchscreen device found"
fi

echo ""
echo "3. 🔧 X11 configuration..."
echo "------------------------"
if [ -f /etc/X11/xorg.conf.d/99-touchscreen.conf ]; then
    echo "✅ Touchscreen configuration exists"
    echo "Configuration:"
    cat /etc/X11/xorg.conf.d/99-touchscreen.conf
else
    echo "❌ No touchscreen configuration found"
fi

echo ""
echo "4. 🌐 Browser touch events..."
echo "----------------------------"
echo "Testing browser touch support..."
echo "Chrome flags for touch:"
echo "  --touch-events=enabled"
echo "  --enable-features=TouchpadOverscrollHistoryNavigation"

echo ""
echo "5. 📊 System information..."
echo "-------------------------"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '\"')"
echo "Kernel: $(uname -r)"
echo "Desktop: $DESKTOP_SESSION"

echo ""
echo "6. 🔄 Event testing..."
echo "--------------------"
echo "Available input devices:"
ls -la /dev/input/event*

echo ""
echo "💡 Troubleshooting tips:"
echo "======================="
echo "• If no touchscreen found: Check hardware connection"
echo "• If device found but no scrolling: Try different scroll methods"
echo "• For web scrolling: Use touch-enabled browser flags"
echo "• Check /var/log/Xorg.0.log for X11 errors"
echo ""
echo "🔧 Manual fixes to try:"
echo "• sudo xinput set-prop [DEVICE_ID] \"libinput Natural Scrolling Enabled\" 1"
echo "• sudo xinput set-prop [DEVICE_ID] \"libinput Scroll Method Enabled\" 0, 0, 1"
echo ""
