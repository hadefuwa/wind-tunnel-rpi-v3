#!/bin/bash

# Git setup and push script for wind-tunnel-rpi-v3

echo "Setting up Git repository..."

# Initialize git if not already done
if [ ! -d ".git" ]; then
    git init
fi

# Add remote origin
git remote add origin https://github.com/hadefuwa/wind-tunnel-rpi-v3.git

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Wind Tunnel Demo - Management Presentation Ready

Features:
- Lightweight Python Flask backend
- Real-time web dashboard
- Live data visualization
- Interactive controls
- Simulation mode for demos
- Professional UI design
- Mobile responsive
- Auto-start capability

Demo ready for management presentation!"

# Push to GitHub
git branch -M main
git push -u origin main

echo "Repository pushed to GitHub!"
echo "Clone on Raspberry Pi with:"
echo "git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git"
