#!/bin/bash

# Advanced Touchscreen Fix for Raspberry Pi
# This script fixes text selection issues and enables proper scrolling

echo "🖱️  Advanced Touchscreen Scrolling Fix"
echo "====================================="

# Stop any running demo first
echo "🛑 Stopping any running demo..."
pkill -f "python3.*app.py" 2>/dev/null || true
pkill -f "chromium" 2>/dev/null || true

# 1. Create advanced X11 touchscreen configuration
echo "⚙️  Creating advanced touchscreen configuration..."
sudo mkdir -p /etc/X11/xorg.conf.d/

# Create comprehensive touchscreen configuration
sudo tee /etc/X11/xorg.conf.d/40-touchscreen.conf > /dev/null <<EOF
# Advanced touchscreen configuration for scrolling
Section "InputClass"
    Identifier "touchscreen catchall"
    MatchIsTouchscreen "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    
    # Disable text selection on touch
    Option "TapButton1" "0"
    Option "TapButton2" "0"
    Option "TapButton3" "0"
    
    # Enable scrolling
    Option "ScrollMethod" "twofinger"
    Option "ScrollButton" "0"
    Option "NaturalScrolling" "true"
    Option "HorizontalScrolling" "true"
    
    # Disable click-and-drag
    Option "TappingDrag" "false"
    Option "TappingDragLock" "false"
    
    # Improve responsiveness
    Option "AccelProfile" "adaptive"
    Option "AccelSpeed" "0.5"
    
    # Disable while typing
    Option "DisableWhileTyping" "false"
EndSection

# Fallback evdev configuration
Section "InputClass"
    Identifier "evdev touchscreen catchall"
    MatchIsTouchscreen "on"
    MatchDevicePath "/dev/input/event*"
    Driver "evdev"
    
    # Disable mouse emulation
    Option "EmulateThirdButton" "false"
    Option "EmulateThirdButtonTimeout" "0"
    Option "EmulateThirdButtonMoveThreshold" "0"
EndSection
EOF

# 2. Create touchscreen gesture script for runtime
echo "👆 Creating touchscreen gesture script..."
cat > ~/touchscreen-gestures-advanced.sh <<'EOF'
#!/bin/bash

# Advanced touchscreen gesture configuration
sleep 3

# Find touchscreen devices
TOUCHSCREEN_DEVICES=$(xinput list | grep -i touch | grep -oP 'id=\K\d+')

if [ -z "$TOUCHSCREEN_DEVICES" ]; then
    echo "No touchscreen devices found"
    exit 1
fi

for DEVICE_ID in $TOUCHSCREEN_DEVICES; do
    echo "Configuring touchscreen device ID: $DEVICE_ID"
    
    # Disable tap-to-click to prevent text selection
    xinput set-prop $DEVICE_ID "libinput Tapping Enabled" 0 2>/dev/null || true
    
    # Enable natural scrolling
    xinput set-prop $DEVICE_ID "libinput Natural Scrolling Enabled" 1 2>/dev/null || true
    
    # Enable horizontal scrolling
    xinput set-prop $DEVICE_ID "libinput Horizontal Scroll Enabled" 1 2>/dev/null || true
    
    # Set scroll method to two-finger
    xinput set-prop $DEVICE_ID "libinput Scroll Method Enabled" 0, 0, 1 2>/dev/null || true
    
    # Disable click method
    xinput set-prop $DEVICE_ID "libinput Click Method Enabled" 0, 0 2>/dev/null || true
    
    # Set as touchscreen (not touchpad)
    xinput set-prop $DEVICE_ID "libinput Device Enabled" 1 2>/dev/null || true
    
    echo "✅ Configured device $DEVICE_ID"
done
EOF

chmod +x ~/touchscreen-gestures-advanced.sh

# 3. Update autostart to use advanced script
echo "🔄 Updating autostart configuration..."
mkdir -p ~/.config/autostart/

cat > ~/.config/autostart/touchscreen-advanced.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Advanced Touchscreen Setup
Exec=/home/matrix/touchscreen-gestures-advanced.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Comment=Advanced touchscreen scrolling configuration
EOF

# 4. Configure browser for touch without text selection
echo "🌐 Configuring browser for touch scrolling..."
mkdir -p ~/.config/chromium/Default/

# Create browser preferences to disable text selection on touch
cat > ~/.config/chromium/Default/Preferences <<EOF
{
   "profile": {
      "default_content_setting_values": {
         "notifications": 2
      }
   },
   "webkit": {
      "webprefs": {
         "minimum_font_size": 12,
         "minimum_logical_font_size": 12
      }
   }
}
EOF

# 5. Create CSS override for web app to prevent text selection
echo "🎨 Creating CSS override for web app..."
cat > /tmp/touch-override.css <<'EOF'
/* Prevent text selection on touch devices */
body, * {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    -webkit-touch-callout: none;
    -webkit-tap-highlight-color: transparent;
}

/* Allow text selection only for input fields */
input, textarea {
    -webkit-user-select: text;
    -moz-user-select: text;
    -ms-user-select: text;
    user-select: text;
}

/* Improve touch scrolling */
body {
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
    touch-action: pan-y;
}

.scrollable, .card, .chart-container {
    touch-action: pan-y;
    -webkit-overflow-scrolling: touch;
}

/* Prevent text selection on buttons and controls */
.btn, button, .control, .metric {
    -webkit-user-select: none !important;
    -moz-user-select: none !important;
    -ms-user-select: none !important;
    user-select: none !important;
    -webkit-touch-callout: none !important;
    -webkit-tap-highlight-color: transparent !important;
}
EOF

# 6. Update system settings for better touch response
echo "⚡ Updating system settings..."
sudo tee -a /boot/config.txt > /dev/null <<EOF

# Advanced touch screen optimization
dtparam=spi=on
gpu_mem=128
disable_overscan=1

# Improve touch responsiveness
hdmi_group=2
hdmi_mode=87
hdmi_cvt=800 480 60 6 0 0 0

# Disable mouse acceleration for better touch feel
dtparam=mouse_emulation=0
EOF

# 7. Install additional tools for gesture support
echo "🛠️  Installing gesture support tools..."
sudo apt update
sudo apt install -y touchegg libinput-gestures

echo ""
echo "✅ Advanced touchscreen fix complete!"
echo "===================================="
echo ""
echo "🔄 IMPORTANT: You must reboot for changes to take effect!"
echo "   sudo reboot"
echo ""
echo "🖱️  After reboot, the touchscreen should:"
echo "   • Scroll without selecting text"
echo "   • Support natural scrolling gestures"
echo "   • Work properly with web applications"
echo ""
echo "🔧 To test after reboot:"
echo "   ./touchscreen-diagnostic.sh"
echo ""
echo "🚀 To start demo after reboot:"
echo "   ./start-touchscreen-demo.sh"
echo ""
