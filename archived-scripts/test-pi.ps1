#!/usr/bin/env pwsh
# Test Pi connection and Flask app

Write-Host "🔗 Testing Pi Connection..." -ForegroundColor Green

# Test basic SSH
Write-Host "📡 Testing SSH connection..." -ForegroundColor Yellow
$sshTest = ssh matrix@192.168.0.117 -o ConnectTimeout=5 -o StrictHostKeyChecking=no "echo 'SSH OK'"
if ($sshTest -eq "SSH OK") {
    Write-Host "✅ SSH connection successful" -ForegroundColor Green
} else {
    Write-Host "❌ SSH connection failed" -ForegroundColor Red
    exit 1
}

# Pull latest changes
Write-Host "📥 Pulling latest changes..." -ForegroundColor Yellow
ssh matrix@192.168.0.117 "cd /home/matrix/wind-tunnel-rpi-v3 && git pull origin main"

# Run debug script
Write-Host "🔍 Running Flask debug script..." -ForegroundColor Yellow
ssh matrix@192.168.0.117 "cd /home/matrix/wind-tunnel-rpi-v3 && python3 debug-flask.py"

# Test Flask app directly
Write-Host "🧪 Testing Flask app..." -ForegroundColor Yellow
ssh matrix@192.168.0.117 "cd /home/matrix/wind-tunnel-rpi-v3/wind-tunnel-demo && timeout 10 python3 backend/app.py" 2>&1 | Select-Object -First 15

Write-Host "🏁 Test complete" -ForegroundColor Green
