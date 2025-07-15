@echo off
echo Testing Pi Connection...
echo.

echo Testing ping...
ping -n 2 192.168.0.117

echo.
echo Testing SSH...
ssh -o ConnectTimeout=5 matrix@192.168.0.117 "echo SSH connection successful"

echo.
echo Pulling latest code...
ssh matrix@192.168.0.117 "cd /home/matrix/wind-tunnel-rpi-v3 && git pull origin main"

echo.
echo Running debug script...
ssh matrix@192.168.0.117 "cd /home/matrix/wind-tunnel-rpi-v3 && python3 debug-flask.py"

echo.
echo Test complete.
pause
