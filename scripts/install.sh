#!/bin/bash

# Void Display Manager Installer Script
# Location: scripts/install.sh

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Base directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/void-dm"
SERVICE_DIR="/etc/sv"
USER_CONFIG_DIR="$HOME/.config/void-dm"

# Install dependencies
echo "Installing dependencies..."
xbps-install -Sy dialog xinit

# Create directories
echo "Creating directories..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$USER_CONFIG_DIR"

# Copy main script
echo "Installing VDM..."
cp "$REPO_DIR/src/void-dm.sh" "$INSTALL_DIR/void-dm"
chmod 755 "$INSTALL_DIR/void-dm"

# Copy default config
echo "Installing default configuration..."
cp "$REPO_DIR/config/sessions" "$CONFIG_DIR/sessions.default"
[ ! -f "$USER_CONFIG_DIR/sessions" ] && cp "$REPO_DIR/config/sessions" "$USER_CONFIG_DIR/sessions"

# Install service
echo "Installing service..."
cp -r "$REPO_DIR/service/void-dm" "$SERVICE_DIR/"
chmod 755 "$SERVICE_DIR/void-dm/run"

# Create symlink to enable service
echo "Enabling service..."
ln -sf "$SERVICE_DIR/void-dm" "/var/service/"

echo "Installation complete!"
echo "VDM will start on next boot, or run 'sv start void-dm' to start now."