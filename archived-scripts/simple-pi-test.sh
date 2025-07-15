#!/bin/bash
# Simple test to run on Pi manually

echo "🔍 Simple Pi Test"
echo "================"

# Check if we're in the right directory
echo "Current directory: $(pwd)"

# Check if project exists
if [ -d "wind-tunnel-rpi-v3" ]; then
    echo "✅ Project directory exists"
    cd wind-tunnel-rpi-v3
    
    # Check demo directory
    if [ -d "wind-tunnel-demo" ]; then
        echo "✅ Demo directory exists"
        cd wind-tunnel-demo
        
        # Check files
        if [ -f "backend/app.py" ]; then
            echo "✅ Backend app.py exists"
        else
            echo "❌ Backend app.py missing"
        fi
        
        if [ -f "frontend/index.html" ]; then
            echo "✅ Frontend index.html exists"
        else
            echo "❌ Frontend index.html missing"
        fi
        
        if [ -f "frontend/logo.png" ]; then
            echo "✅ Frontend logo.png exists"
        else
            echo "❌ Frontend logo.png missing"
        fi
        
        # Try to run Flask app
        echo "🧪 Testing Flask app..."
        python3 backend/app.py &
        FLASK_PID=$!
        
        sleep 5
        
        # Test if it's responding
        if curl -s http://localhost:5000 > /dev/null; then
            echo "✅ Flask app is responding"
            
            # Test if HTML is returned
            HTML_LENGTH=$(curl -s http://localhost:5000 | wc -c)
            echo "📄 HTML response length: $HTML_LENGTH characters"
            
            if [ "$HTML_LENGTH" -gt 1000 ]; then
                echo "✅ HTML response looks good"
            else
                echo "❌ HTML response too short"
            fi
            
        else
            echo "❌ Flask app not responding"
        fi
        
        # Clean up
        kill $FLASK_PID 2>/dev/null
        
    else
        echo "❌ Demo directory missing"
    fi
else
    echo "❌ Project directory missing"
fi

echo "🏁 Test complete"
