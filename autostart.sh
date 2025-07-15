#!/bin/bash

# Autostart script for Wind Tunnel Demo
# This script is called by the desktop environment on boot

# Wait for desktop environment to load
sleep 10

# Get the script directory (assuming this is in the project root)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Run the main startup script
"$SCRIPT_DIR/start_demo.sh"
