# Raspberry Pi SSH Connection Details

## SSH Access Information
- **IP Address:** 192.168.0.117
- **Username:** matrix
- **Password:** matrix123

## SSH Connection Command
```bash
ssh matrix@192.168.0.117
```

## Quick Demo Setup Commands (No-Scroll Version)
```bash
# 1. Connect to Pi
ssh matrix@192.168.0.117

# 2. Navigate to project
cd wind-tunnel-rpi-v3

# 3. Pull latest updates
git pull origin main

# 4. Start no-scroll demo (fits entire screen)
chmod +x start-no-scroll-demo.sh
./start-no-scroll-demo.sh
```

## Demo Features (No-Scroll Version)
- **Entire app fits on screen** - No scrolling required
- **Touchscreen optimized** - Perfect for touch displays
- **Responsive design** - Works on any screen size
- **Compact layout** - Efficient use of screen space
- **Professional interface** - Clean, modern design

## Demo Access URLs
- **Local on Pi:** http://localhost:5000
- **Remote access:** http://192.168.0.117:5000

## Demo Control Commands
```bash
# Start demo
python3 app.py

# Stop demo
Ctrl+C

# Check if demo is running
ps aux | grep python3

# Kill demo process (if needed)
pkill -f "python3 app.py"
```

## Troubleshooting
```bash
# Check Python version
python3 --version

# Check if Flask is installed
pip3 show flask

# Check network connectivity
ping 8.8.8.8

# Check if port 5000 is available
netstat -tlnp | grep :5000

# Check system resources
htop
```

## File Locations on Pi
- **Project root:** `/home/matrix/wind-tunnel-rpi-v3/`
- **Backend:** `/home/matrix/wind-tunnel-rpi-v3/wind-tunnel-demo/backend/`
- **Frontend:** `/home/matrix/wind-tunnel-rpi-v3/wind-tunnel-demo/frontend/`

## Emergency Demo Commands
```bash
# Quick test if Python works
python3 -c "print('Python is working')"

# Quick test if Flask works
python3 -c "import flask; print('Flask is working')"

# Start demo in background
nohup python3 app.py &

# Check demo logs
tail -f nohup.out
```

## Demo Presentation Notes
- Demo auto-starts in simulation mode
- Shows real-time data immediately
- Professional UI with live charts
- Works on any device with web browser
- No additional software needed

---

**Created:** July 15, 2025  
**For:** Management Demo Presentation  
**Status:** Ready for demo  

**Remember:** The demo will auto-start showing live data - perfect for impressing management!
