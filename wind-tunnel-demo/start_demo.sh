#!/bin/bash

# Wind Tunnel Demo - Quick Start Script

echo "🌪️  Wind Tunnel Demo Setup"
echo "=========================="

# Navigate to backend directory
cd "$(dirname "$0")/backend"

# Install Python dependencies if needed
if [ ! -f ".deps_installed" ]; then
    echo "📦 Installing Python dependencies..."
    pip3 install -r requirements.txt
    touch .deps_installed
fi

# Start the demo
echo "🚀 Starting Wind Tunnel Demo..."
echo "📊 Management Demo Mode"
echo "🔗 Open your browser to: http://localhost:5000"
echo ""
echo "Demo Features:"
echo "✅ Real-time data simulation"
echo "✅ Interactive dashboard"
echo "✅ Live charts and metrics"
echo "✅ Start/Stop controls"
echo "✅ Hardware simulation mode"
echo ""
echo "Press Ctrl+C to stop"
echo ""

python3 app.py
