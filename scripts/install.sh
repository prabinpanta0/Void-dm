#!/bin/bash

# Void Display Manager Installer Script
# Location: scripts/install.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo >&2 "Please run as root"
    exit 1
fi

# Base directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/void-dm"
SERVICE_DIR="/etc/sv"
USER_CONFIG_DIR="~/.config/void-dm"

# Install dependencies
echo "Installing dependencies..."
sudo xbps-install -Sy dialog xinit

# Create directories
echo "Creating directories..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$USER_CONFIG_DIR"

# Copy main script
echo "Installing VDM..."
if [ -f "$REPO_DIR/src/void-dm.sh" ]; then
    cp "$REPO_DIR/src/void-dm.sh" "$INSTALL_DIR/void-dm"
    chmod 755 "$INSTALL_DIR/void-dm"
# Copy default config
echo "Installing default configuration..."
if [ -f "$REPO_DIR/config/sessions" ]; then
    cp "$REPO_DIR/config/sessions" "$CONFIG_DIR/sessions.default"
    [ ! -f "$USER_CONFIG_DIR/sessions" ] && cp "$REPO_DIR/config/sessions" "$USER_CONFIG_DIR/sessions"
else
    echo "Error: $REPO_DIR/config/sessions not found."
    exit 1
fi
fi
fi

# Install service
echo "Installing service..."
if [ -d "$REPO_DIR/service/void-dm" ]; then
    cp -r "$REPO_DIR/service/void-dm" "$SERVICE_DIR/"
    chmod 755 "$SERVICE_DIR/void-dm/run"
else
    echo "Error: $REPO_DIR/service/void-dm directory not found."
    exit 1
fi

# Create symlink to enable service
echo "Enabling service..."
if [ ! -d "/var/service/" ]; then
    echo "Error: /var/service/ directory does not exist."
    exit 1
fi
ln -sf "$SERVICE_DIR/void-dm" "/var/service/"
chmod 755 "$SERVICE_DIR/void-dm/run"

# Create symlink to enable service
echo "Enabling service..."
ln -sf "$SERVICE_DIR/void-dm" "/var/service/"

echo "Installation complete!"
echo "VDM will start on next boot, or run 'sv start void-dm' to start now."