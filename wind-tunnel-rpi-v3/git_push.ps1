Write-Host "🌪️  Wind Tunnel Demo - Git Push Script" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Change to project directory
Set-Location "c:\Users\Adefu\OneDrive\Documents\wind-tunnel-rpi-v3"

Write-Host "Initializing Git repository..." -ForegroundColor Yellow
git init

Write-Host "Adding remote origin..." -ForegroundColor Yellow
git remote add origin https://github.com/hadefuwa/wind-tunnel-rpi-v3.git

Write-Host "Adding all files..." -ForegroundColor Yellow
git add .

Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m "Initial commit: Wind Tunnel Demo - Management Presentation Ready"

Write-Host "Setting main branch..." -ForegroundColor Yellow
git branch -M main

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

Write-Host ""
Write-Host "✅ Repository pushed to GitHub successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📱 On your Raspberry Pi, run:" -ForegroundColor Cyan
Write-Host "   git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git" -ForegroundColor White
Write-Host "   cd wind-tunnel-rpi-v3" -ForegroundColor White
Write-Host "   chmod +x setup_pi.sh" -ForegroundColor White
Write-Host "   ./setup_pi.sh" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Demo will be ready in 2 minutes!" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to continue..."
