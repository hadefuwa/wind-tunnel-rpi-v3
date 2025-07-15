# Git Workflow for Wind Tunnel RPi Project

## Development Workflow

### 🖥️ On Windows Machine (Development)

1. **Make changes to your project**
2. **Push to GitHub:**
   ```cmd
   # Double-click git_push.bat
   # OR run manually:
   git add .
   git commit -m "Your commit message"
   git push origin main
   ```

### 🍓 On Raspberry Pi (Production)

1. **First time setup:**
   ```bash
   git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git
   cd wind-tunnel-rpi-v3
   chmod +x setup_pi.sh
   ./setup_pi.sh
   ```

2. **For updates (every time you push new code):**
   ```bash
   cd wind-tunnel-rpi-v3
   ./git-pull-update.sh
   ```

3. **Start the demo:**
   ```bash
   ./start-touchscreen-demo.sh
   ```

## Quick Reference Commands

### Windows Commands
- `git_push.bat` - Push all changes to GitHub
- `git_push.ps1` - PowerShell version of push script

### Raspberry Pi Commands
- `./git-pull-update.sh` - Pull latest changes and update system
- `./setup_pi.sh` - Initial setup (run once)
- `./start-touchscreen-demo.sh` - Start demo with touchscreen support
- `./touchscreen-setup.sh` - Configure touchscreen scrolling
- `./touchscreen-diagnostic.sh` - Troubleshoot touchscreen issues

## Workflow Steps

1. **Develop on Windows** → Edit files in VS Code
2. **Push to GitHub** → Run `git_push.bat`
3. **Update Pi** → SSH to Pi and run `./git-pull-update.sh`
4. **Test on Pi** → Run `./start-touchscreen-demo.sh`

## SSH Access to Pi

```bash
# Connect to your Raspberry Pi
ssh matrix@192.168.0.117

# Navigate to project
cd wind-tunnel-rpi-v3

# Pull latest changes
./git-pull-update.sh
```

## Automated Updates

You can also set up automatic updates on the Pi:

```bash
# Create a cron job for automatic updates (optional)
crontab -e

# Add this line to check for updates every hour:
0 * * * * cd /home/matrix/wind-tunnel-rpi-v3 && ./git-pull-update.sh > /tmp/git-update.log 2>&1
```

## File Structure

```
wind-tunnel-rpi-v3/
├── git_push.bat              # Windows: Push to GitHub
├── git_push.ps1              # Windows: PowerShell push script
├── git-pull-update.sh        # Pi: Pull and update
├── setup_pi.sh               # Pi: Initial setup
├── start-touchscreen-demo.sh # Pi: Start demo with touch support
├── touchscreen-setup.sh      # Pi: Configure touchscreen
├── touchscreen-diagnostic.sh # Pi: Diagnose touchscreen issues
└── wind-tunnel-demo/
    ├── backend/
    │   ├── app.py
    │   └── requirements.txt
    └── frontend/
        └── index.html
```

## Best Practices

1. **Always develop on Windows** - Use VS Code for editing
2. **Always push from Windows** - Use `git_push.bat`
3. **Always pull on Pi** - Use `./git-pull-update.sh`
4. **Test on Pi** - Use `./start-touchscreen-demo.sh`
5. **Keep Pi updated** - Run pull script after each Windows push

## Troubleshooting

- **Push fails**: Check internet connection and GitHub credentials
- **Pull fails**: Check Pi internet connection and SSH to Pi
- **Demo not working**: Run diagnostic scripts on Pi
- **Touchscreen issues**: Run `./touchscreen-diagnostic.sh`
