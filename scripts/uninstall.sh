#!/bin/bash

# Void Display Manager Uninstaller Script
# Location: scripts/uninstall.sh

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Stop service if running
echo "Stopping VDM service..."
sv down void-dm 2>/dev/null || true

# Remove service
echo "Removing service..."
rm -f "/var/service/void-dm"
rm -rf "/etc/sv/void-dm"

# Remove binary
echo "Removing VDM..."
rm -f "/usr/local/bin/void-dm"

# Remove global config
echo "Removing global configuration..."
rm -rf "/etc/void-dm"

# Ask about user config
read -p "Remove user configuration (~/.config/void-dm)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing user configuration..."
    rm -rf "$HOME/.config/void-dm"
fi

echo "Uninstallation complete!"