@echo off
REM Quick Update Script for Raspberry Pi
REM This script helps you update the Pi after pushing from Windows

echo 🔄 Wind Tunnel RPi - Remote Update Helper
echo ==========================================

echo.
echo 📝 After running git_push.bat, follow these steps:
echo.
echo 1. SSH to your Raspberry Pi:
echo    ssh matrix@192.168.0.117
echo.
echo 2. Navigate to project directory:
echo    cd wind-tunnel-rpi-v3
echo.
echo 3. Pull latest changes:
echo    ./git-pull-update.sh
echo.
echo 4. Start the demo:
echo    ./start-touchscreen-demo.sh
echo.
echo 🌐 Then access the demo at:
echo    http://192.168.0.117:5000
echo.
echo 💡 Tip: Bookmark this URL for quick access!
echo.
pause
