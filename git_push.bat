@echo off
echo 🌪️  Wind Tunnel Demo -echo 🔄 For updates on Pi, run:
echo    git pull origin main
echo    ./start-no-scroll-demo.sht Push Script
echo ====================================

echo Initializing Git repository...
git init

echo Adding remote origin...
git remote add origin https://github.com/hadefuwa/wind-tunnel-rpi-v3.git

echo Adding all files...
git add .

echo Committing changes...
git commit -m "Major Update: No-Scroll Responsive Design

- Redesigned entire app to fit on screen without scrolling
- Optimized layout for touchscreen displays
- Responsive design that adapts to any screen size
- Compact UI with efficient space utilization
- Created start-no-scroll-demo.sh launcher
- Enhanced user experience for touch devices
- Eliminated need for scrolling functionality"

echo Setting main branch...
git branch -M main

echo Pushing to GitHub...
git push -u origin main

echo.
echo ✅ Repository pushed to GitHub successfully!
echo.
echo 📱 On your Raspberry Pi, run:
echo    git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git
echo    cd wind-tunnel-rpi-v3
echo    chmod +x setup_pi.sh
echo    ./setup_pi.sh
echo.
echo � For future updates, run on Pi:
echo    git pull origin main
echo    ./touchscreen-setup.sh
echo.
echo �🚀 Demo will be ready in 2 minutes!
echo.
pause
