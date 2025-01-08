# Void Display Manager (VDM)

A lightweight, terminal-based display manager specifically designed for Void Linux. VDM provides a simple, efficient, and customizable login experience while maintaining the pure terminal aesthetic.

## Features

- Minimal terminal-based interface
- Session management for multiple desktop environments/window managers
- Secure user authentication
- Easy installation and configuration
- Automatic .xinitrc generation
- Support for custom sessions

## Dependencies

- dialog
- xinit

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/void-display-manager.git
cd void-display-manager
```

2. Run the installer:
```bash
./scripts/install.sh
```

## Uninstallation

To remove VDM:
```bash
./scripts/uninstall.sh
```

## Configuration

Edit `~/.config/void-dm/sessions` to add or remove desktop environments:
```
name:/path/to/executable
```

Example:
```
dwm:/usr/bin/dwm
i3:/usr/bin/i3
```

## License

MIT License - See LICENSE file for details