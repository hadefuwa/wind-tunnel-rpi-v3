#!/bin/bash

# Wind Tunnel RPi v3 - Quick Setup Script for Raspberry Pi
# Run this script after cloning the repository

echo "🌪️  Wind Tunnel RPi v3 - Setup Script"
echo "======================================"

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Python and dependencies
echo "🐍 Installing Python and pip..."
sudo apt install python3 python3-pip git -y

# Install SPI tools
echo "🔌 Installing SPI tools..."
sudo apt install python3-spidev -y

# Navigate to demo directory
echo "📁 Setting up demo environment..."
cd wind-tunnel-demo/backend

# Install Python requirements
echo "📋 Installing Python requirements..."
pip3 install -r requirements.txt

# Create systemd service (optional)
echo "⚙️  Creating systemd service..."
sudo tee /etc/systemd/system/wind-tunnel.service > /dev/null <<EOF
[Unit]
Description=Wind Tunnel Data Acquisition
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=$PWD
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable SPI interface
echo "🔧 Enabling SPI interface..."
sudo raspi-config nonint do_spi 0

# Get Pi IP address
PI_IP=$(hostname -I | cut -d' ' -f1)

echo ""
echo "✅ Setup Complete!"
echo "=================="
echo ""
echo "🚀 To start the demo:"
echo "   cd wind-tunnel-demo/backend"
echo "   python3 app.py"
echo ""
echo "🌐 Access the dashboard:"
echo "   Local:  http://localhost:5000"
echo "   Remote: http://$PI_IP:5000"
echo ""
echo "🔧 To enable auto-start:"
echo "   sudo systemctl enable wind-tunnel.service"
echo "   sudo systemctl start wind-tunnel.service"
echo ""
echo "📊 Demo is ready for management presentation!"
echo ""
