#!/bin/bash

# Git Pull and Update Script for Raspberry Pi
# This script pulls latest changes from GitHub and updates the system

echo "🔄 Wind Tunnel RPi - Git Pull & Update"
echo "====================================="

# Check if we're in the correct directory
if [ ! -f "README.md" ] || [ ! -d "wind-tunnel-demo" ]; then
    echo "❌ Error: Not in the wind-tunnel-rpi-v3 directory"
    echo "Please run this script from the project root directory"
    exit 1
fi

# Check if git repository exists
if [ ! -d ".git" ]; then
    echo "❌ Error: Not a git repository"
    echo "Please clone the repository first:"
    echo "git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git"
    exit 1
fi

# Stop any running demo
echo "🛑 Stopping any running demo..."
pkill -f "python3.*app.py" 2>/dev/null || true

# Pull latest changes
echo "📥 Pulling latest changes from GitHub..."
git fetch origin
git pull origin main

# Check if pull was successful
if [ $? -eq 0 ]; then
    echo "✅ Successfully pulled latest changes"
else
    echo "❌ Failed to pull changes from GitHub"
    echo "Please check your internet connection and try again"
    exit 1
fi

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x *.sh 2>/dev/null || true

# Update touchscreen configuration if needed
if [ -f "touchscreen-setup.sh" ]; then
    echo "🖱️  Updating touchscreen configuration..."
    ./touchscreen-setup.sh
fi

# Update Python dependencies
echo "🐍 Updating Python dependencies..."
cd wind-tunnel-demo/backend
pip3 install -r requirements.txt --upgrade

# Return to project root
cd ../..

# Check system status
echo "🔍 System Status:"
echo "  - Project directory: $(pwd)"
echo "  - Git status: $(git status --porcelain | wc -l) modified files"
echo "  - Last commit: $(git log -1 --pretty=format:'%h - %s (%cr)')"

# Get IP address for access
PI_IP=$(hostname -I | cut -d' ' -f1)

echo ""
echo "✅ Update Complete!"
echo "=================="
echo ""
echo "🚀 To start the demo:"
echo "   ./start-touchscreen-demo.sh"
echo ""
echo "🌐 Access URLs:"
echo "   Local:  http://localhost:5000"
echo "   Remote: http://$PI_IP:5000"
echo ""
echo "📱 Features updated:"
echo "   • Latest code from GitHub"
echo "   • Touchscreen scrolling support"
echo "   • Updated dependencies"
echo "   • Enhanced web interface"
echo ""
