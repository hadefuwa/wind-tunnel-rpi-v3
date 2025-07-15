#!/bin/bash

# Touchscreen Scrolling Fix for Raspberry Pi
# This script enables proper touchscreen scrolling functionality

echo "🖱️  Touchscreen Scrolling Configuration"
echo "======================================"

# 1. Install required packages
echo "📦 Installing touchscreen packages..."
sudo apt update
sudo apt install -y xinput-calibrator xserver-xorg-input-libinput evtest

# 2. Check current input devices
echo "🔍 Current input devices:"
xinput list

# 3. Create touchscreen configuration
echo "⚙️  Creating touchscreen configuration..."
sudo mkdir -p /etc/X11/xorg.conf.d/

# Create libinput configuration for touchscreen
sudo tee /etc/X11/xorg.conf.d/99-touchscreen.conf > /dev/null <<EOF
# Touchscreen configuration for scrolling support
Section "InputClass"
    Identifier "touchscreen"
    MatchIsTouchscreen "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "TappingDrag" "on"
    Option "DisableWhileTyping" "on"
    Option "AccelProfile" "adaptive"
    Option "AccelSpeed" "0.3"
    Option "NaturalScrolling" "true"
    Option "ScrollMethod" "twofinger"
    Option "HorizontalScrolling" "true"
EndSection

# Alternative evdev configuration (if libinput doesn't work)
Section "InputClass"
    Identifier "evdev touchscreen catchall"
    MatchIsTouchscreen "on"
    MatchDevicePath "/dev/input/event*"
    Driver "evdev"
    Option "EmulateThirdButton" "1"
    Option "EmulateThirdButtonTimeout" "750"
    Option "EmulateThirdButtonMoveThreshold" "30"
EndSection
EOF

# 4. Enable touch scrolling in browser
echo "🌐 Configuring browser touch scrolling..."

# Create autostart directory if it doesn't exist
mkdir -p ~/.config/autostart/

# Create touch scrolling autostart script
cat > ~/.config/autostart/touchscreen-setup.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Touchscreen Setup
Exec=/home/pi/touchscreen-gestures.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

# 5. Create gesture script
cat > ~/touchscreen-gestures.sh <<'EOF'
#!/bin/bash

# Wait for X server to start
sleep 5

# Enable touch scrolling for specific touchscreen device
# You may need to adjust the device name based on your touchscreen
TOUCHSCREEN_ID=$(xinput list | grep -i touch | head -n1 | grep -oP 'id=\K\d+')

if [ ! -z "$TOUCHSCREEN_ID" ]; then
    # Enable natural scrolling
    xinput set-prop $TOUCHSCREEN_ID "libinput Natural Scrolling Enabled" 1
    
    # Enable horizontal scrolling
    xinput set-prop $TOUCHSCREEN_ID "libinput Horizontal Scroll Enabled" 1
    
    # Set scroll method to two-finger
    xinput set-prop $TOUCHSCREEN_ID "libinput Scroll Method Enabled" 0, 0, 1
    
    echo "Touchscreen scrolling enabled for device ID: $TOUCHSCREEN_ID"
else
    echo "No touchscreen device found"
fi
EOF

chmod +x ~/touchscreen-gestures.sh

# 6. Install gesture recognition software
echo "👆 Installing gesture recognition..."
sudo apt install -y libinput-tools

# 7. Create web browser configuration for touch
echo "🌐 Creating browser touch configuration..."
mkdir -p ~/.config/chromium/

cat > ~/.config/chromium/touch-config.json <<EOF
{
  "touch_scrolling": true,
  "smooth_scrolling": true,
  "enable_touch_adjustment": true,
  "touch_events": "enabled"
}
EOF

# 8. Configure system for better touch response
echo "⚡ Optimizing touch response..."
sudo tee -a /boot/config.txt > /dev/null <<EOF

# Touch screen optimization
dtparam=spi=on
gpu_mem=128
disable_overscan=1

# Improve touch responsiveness
hdmi_group=2
hdmi_mode=87
hdmi_cvt=800 480 60 6 0 0 0
EOF

echo ""
echo "✅ Touchscreen scrolling setup complete!"
echo "======================================"
echo ""
echo "🔄 Next steps:"
echo "1. Reboot your Raspberry Pi: sudo reboot"
echo "2. After reboot, test scrolling in browser"
echo "3. If still not working, run the diagnostic script"
echo ""
echo "🔧 To test touchscreen devices:"
echo "   xinput list"
echo "   sudo evtest"
echo ""
echo "📱 For web browsing, use:"
echo "   chromium-browser --touch-events=enabled --enable-features=TouchpadOverscrollHistoryNavigation"
echo ""
