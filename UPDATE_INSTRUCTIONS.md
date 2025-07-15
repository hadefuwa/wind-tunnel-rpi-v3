# 🔄 Raspberry Pi Code Update Instructions

This document provides step-by-step instructions for updating your Wind Tunnel Demo code on the Raspberry Pi after making changes.

## 📋 Prerequisites

- Raspberry Pi with SSH access enabled
- Git installed on the Pi
- Project already cloned to the Pi
- Working internet connection

## 🚀 Quick Update Process

### Step 1: Connect to Your Raspberry Pi

```bash
# SSH into your Raspberry Pi
ssh matrix@192.168.0.117
# Password: matrix123

# Or use the hostname if configured
ssh matrix@raspberrypi.local
```

### Step 2: Navigate to Project Directory

```bash
# Navigate to the project folder
cd ~/wind-tunnel-rpi-v3

# Verify you're in the right directory
pwd
# Should show: /home/matrix/wind-tunnel-rpi-v3
```

### Step 3: Stop Any Running Services

```bash
# Stop the demo if it's running
sudo pkill -f "python3 app.py"

# Or stop the systemd service if using it
sudo systemctl stop wind-tunnel-demo.service

# Kill any browser instances
sudo pkill -f chromium-browser
sudo pkill -f firefox
```

### Step 4: Pull Latest Changes

```bash
# Fetch and pull the latest changes from GitHub
git pull origin main

# Check if update was successful
git status
# Should show: "Your branch is up to date with 'origin/main'"
```

### Step 5: Update Dependencies (if requirements.txt changed)

```bash
# Navigate to backend directory
cd ~/wind-tunnel-rpi-v3/backend

# Update Python packages
pip3 install -r requirements.txt --upgrade

# Go back to project root
cd ~/wind-tunnel-rpi-v3
```

### Step 6: Make Scripts Executable (if new scripts were added)

```bash
# Make sure all scripts are executable
chmod +x *.sh

# Specifically ensure startup scripts are executable
chmod +x start_demo.sh
chmod +x autostart.sh
chmod +x setup_autostart.sh
```

### Step 7: Test the Update

```bash
# Test the application manually
./start_demo.sh

# If it works, press Ctrl+C to stop, then proceed to restart services
```

### Step 8: Restart Services (if using systemd)

```bash
# Reload systemd configuration
sudo systemctl daemon-reload

# Restart the service
sudo systemctl restart wind-tunnel-demo.service

# Check service status
sudo systemctl status wind-tunnel-demo.service
```

## 🔧 Complete Update Script

Create this script on your Pi for one-command updates:

```bash
# Create update script
nano ~/update_wind_tunnel.sh
```

Copy and paste this content:

```bash
#!/bin/bash

echo "🔄 Starting Wind Tunnel Demo Update..."

# Navigate to project directory
cd ~/wind-tunnel-rpi-v3

# Stop running services
echo "🛑 Stopping running services..."
sudo pkill -f "python3 app.py"
sudo pkill -f chromium-browser
sudo pkill -f firefox
sudo systemctl stop wind-tunnel-demo.service 2>/dev/null

# Pull latest changes
echo "📥 Pulling latest changes..."
git pull origin main

# Update dependencies
echo "📦 Updating dependencies..."
cd backend
pip3 install -r requirements.txt --upgrade
cd ..

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x *.sh

# Test the application
echo "🧪 Testing application..."
timeout 10s ./start_demo.sh &
sleep 5

# Check if Flask is running
if curl -s http://localhost:5000/api/status > /dev/null 2>&1; then
    echo "✅ Application is working!"
    sudo pkill -f "python3 app.py"
    sudo pkill -f chromium-browser
else
    echo "❌ Application test failed!"
    exit 1
fi

# Restart services
echo "🚀 Restarting services..."
sudo systemctl daemon-reload
sudo systemctl restart wind-tunnel-demo.service

echo "🎯 Update complete! Wind Tunnel Demo is ready."
echo "📱 Access at: http://$(hostname -I | awk '{print $1}'):5000"
```

Make it executable:

```bash
chmod +x ~/update_wind_tunnel.sh
```

## ⚡ One-Command Update

After creating the update script, you can update with just:

```bash
~/update_wind_tunnel.sh
```

## 🔍 Troubleshooting

### If Git Pull Fails:

```bash
# Check for local changes
git status

# If there are local changes, stash them
git stash

# Try pulling again
git pull origin main

# Apply stashed changes if needed
git stash pop
```

### If Dependencies Fail to Install:

```bash
# Update pip first
python3 -m pip install --upgrade pip

# Clear pip cache
pip3 cache purge

# Try installing dependencies again
pip3 install -r backend/requirements.txt --upgrade
```

### If Service Won't Start:

```bash
# Check service logs
sudo journalctl -u wind-tunnel-demo.service -f

# Check if port is already in use
sudo lsof -i :5000

# Kill process using port 5000
sudo kill -9 $(sudo lsof -t -i:5000)
```

### If Browser Won't Open:

```bash
# Check if X server is running
echo $DISPLAY

# Set display if not set
export DISPLAY=:0

# Test browser manually
chromium-browser --kiosk http://localhost:5000
```

## 📝 Update Checklist

- [ ] SSH into Raspberry Pi
- [ ] Navigate to project directory
- [ ] Stop running services
- [ ] Pull latest changes
- [ ] Update dependencies (if needed)
- [ ] Make scripts executable
- [ ] Test application
- [ ] Restart services
- [ ] Verify application is accessible

## 🚨 Emergency Recovery

If something goes wrong:

```bash
# Go to project directory
cd ~/wind-tunnel-rpi-v3

# Reset to last known working state
git reset --hard HEAD

# Or reset to specific commit
git reset --hard [COMMIT_HASH]

# Force pull from GitHub
git fetch origin
git reset --hard origin/main

# Reinstall dependencies
pip3 install -r backend/requirements.txt --force-reinstall
```

## 📞 Quick Reference Commands

```bash
# Update everything
~/update_wind_tunnel.sh

# Manual update
cd ~/wind-tunnel-rpi-v3 && git pull origin main

# Start demo
./start_demo.sh

# Stop demo
sudo pkill -f "python3 app.py"

# Check service status
sudo systemctl status wind-tunnel-demo.service

# View logs
sudo journalctl -u wind-tunnel-demo.service -f
```

---

💡 **Tip**: Bookmark this document and always run the update script after making changes to ensure your Raspberry Pi has the latest code!
