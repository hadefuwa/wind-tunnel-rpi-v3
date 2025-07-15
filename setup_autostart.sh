#!/bin/bash

# Setup script for Wind Tunnel Demo autostart on Raspberry Pi

echo "🔧 Setting up Wind Tunnel Demo autostart..."

# Get the current directory
CURRENT_DIR="$(pwd)"
PROJECT_DIR="$(dirname "$(readlink -f "$0")")"

echo "📁 Project directory: $PROJECT_DIR"

# Make scripts executable
chmod +x "$PROJECT_DIR/start_demo.sh"
chmod +x "$PROJECT_DIR/autostart.sh"

# Create autostart directory if it doesn't exist
mkdir -p ~/.config/autostart

# Create desktop entry for autostart
cat > ~/.config/autostart/wind-tunnel-demo.desktop << EOF
[Desktop Entry]
Type=Application
Name=Wind Tunnel Demo
Comment=Start Wind Tunnel Demo on boot
Exec=$PROJECT_DIR/autostart.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
StartupNotify=false
Terminal=false
EOF

echo "✅ Created autostart desktop entry"

# Also create a systemd service as backup
sudo tee /etc/systemd/system/wind-tunnel-demo.service > /dev/null << EOF
[Unit]
Description=Wind Tunnel Demo Service
After=network.target graphical-session.target
Wants=graphical-session.target

[Service]
Type=simple
User=pi
Group=pi
WorkingDirectory=$PROJECT_DIR
ExecStart=$PROJECT_DIR/start_demo.sh
Restart=always
RestartSec=10
Environment=DISPLAY=:0
Environment=HOME=/home/pi

[Install]
WantedBy=graphical-session.target
EOF

echo "✅ Created systemd service"

# Enable the service (but don't start it yet)
sudo systemctl daemon-reload
sudo systemctl enable wind-tunnel-demo.service

echo ""
echo "🎯 Setup complete! Choose your startup method:"
echo ""
echo "Option 1 - Desktop Autostart (Recommended):"
echo "   - Will start automatically when desktop loads"
echo "   - Already configured and ready"
echo ""
echo "Option 2 - Systemd Service:"
echo "   - sudo systemctl start wind-tunnel-demo.service"
echo "   - sudo systemctl enable wind-tunnel-demo.service"
echo ""
echo "Option 3 - Manual Start:"
echo "   - ./start_demo.sh"
echo ""
echo "🔄 Reboot your Pi to test autostart, or run './start_demo.sh' manually"
