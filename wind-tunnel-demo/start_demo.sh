#!/bin/bash

# Wind Tunnel Demo - Quick Start Script

echo "🌪️  Wind Tunnel Demo Setup"
echo "=========================="

# Install Python dependencies
echo "📦 Installing Python dependencies..."
cd backend
pip install -r requirements.txt

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

python app.py
