# Touchscreen Scrolling Fix for Raspberry Pi - Quick Reference

## Problem
Unable to scroll up/down with finger touch on Raspberry Pi touchscreen

## Quick Solutions

### Solution 1: Install and run the automated fix
```bash
# Download and run the setup script
chmod +x touchscreen-setup.sh
./touchscreen-setup.sh

# Reboot system
sudo reboot
```

### Solution 2: Manual configuration
```bash
# Install required packages
sudo apt update
sudo apt install -y xinput-calibrator xserver-xorg-input-libinput

# Create touchscreen configuration
sudo nano /etc/X11/xorg.conf.d/99-touchscreen.conf
```

Add this configuration:
```
Section "InputClass"
    Identifier "touchscreen"
    MatchIsTouchscreen "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
    Option "ScrollMethod" "twofinger"
    Option "HorizontalScrolling" "true"
EndSection
```

### Solution 3: Browser-specific fix
```bash
# For Chromium browser
chromium-browser --touch-events=enabled --enable-features=TouchpadOverscrollHistoryNavigation

# For Firefox
firefox --enable-touch-events
```

### Solution 4: Runtime xinput commands
```bash
# Find touchscreen device
xinput list

# Enable scrolling (replace X with device ID)
xinput set-prop X "libinput Natural Scrolling Enabled" 1
xinput set-prop X "libinput Scroll Method Enabled" 0, 0, 1
```

## For Your Wind Tunnel App

Since you're using a web-based interface, add these CSS properties to improve touch scrolling:

```css
/* Add to your CSS */
body {
    -webkit-overflow-scrolling: touch;
    overflow-scrolling: touch;
}

.scrollable-content {
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
}
```

## Testing
1. Run diagnostic script: `./touchscreen-diagnostic.sh`
2. Test scrolling in browser with your wind tunnel app
3. Check `/var/log/Xorg.0.log` for errors

## Troubleshooting
- If scrolling still doesn't work, try different scroll methods
- Some touchscreens require specific drivers
- Check for hardware compatibility issues
- Ensure proper calibration

## Common Issues
- **Device not detected**: Check hardware connection
- **Scrolling too sensitive**: Adjust AccelSpeed in config
- **Two-finger scrolling**: Enable in libinput settings
- **Web app scrolling**: Use touch-enabled browser flags
