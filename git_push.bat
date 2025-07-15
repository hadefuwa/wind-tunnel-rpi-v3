@echo off
echo 🌪️  Wind Tunnel Demo - Git Push Script
echo ====================================

echo Initializing Git repository...
git init

echo Adding remote origin...
git remote add origin https://github.com/hadefuwa/wind-tunnel-rpi-v3.git

echo Adding all files...
git add .

echo Committing changes...
git commit -m "Fix: Touchscreen text selection and Chrome extension errors

- Added advanced touchscreen fix to prevent text selection
- Updated web app CSS to disable user-select on touch
- Added error handling for Chrome extension conflicts
- Improved touch scrolling behavior
- Added quick fix script for immediate application
- Enhanced JavaScript error handling"

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
