# Dotfiles - Arch Linux + Hyprland

Personal dotfiles for Arch Linux with Hyprland (Wayland compositor) and GNU Stow.

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

This will install all packages and create symlinks for your configuration files.

## Managing Dotfiles

Each directory represents a component that can be installed/uninstalled independently:

```bash
# Install a component
stow <component-name>

# Example: Install zsh configuration
stow zsh

# Remove a component
stow -D <component-name>

# Reinstall after adding new files
stow -R <component-name>
```

**Important:** Always run stow commands from the `/home/yannic/dotfiles` directory.

## Keychron Keyboard Bluetooth Setup

Keychron keyboards require a specific sequence to pair correctly via Bluetooth:

1. **Remove old pairing** (if exists)
   - Open Blueman Manager
   - Right-click the keyboard → Remove

2. **Enter pairing mode**
   - Hold `Fn + [1-3]` on the keyboard (choose slot 1, 2, or 3)
   - Wait for LED to blink

3. **Search for device**
   - In Blueman Manager: Click "Search"
   - Or in terminal: `bluetoothctl` → `scan on`

4. **Pair (DO NOT connect yet!)**
   - Right-click device → "Pair"
   - Or in bluetoothctl: `pair <MAC address>`
   - Wait for pairing to complete and keyboard to disconnect

5. **Connect**
   - Double-click the device in Blueman Manager
   - Or in bluetoothctl: `connect <MAC address>`

6. **Trust the device**
   - Right-click device → "Trusted"
   - Or in bluetoothctl: `trust <MAC address>`

**Note:** The order is crucial - pairing must happen before connecting!

## Key Components

| Component | Description |
|-----------|-------------|
| **hyprland** | Wayland compositor configuration |
| **waybar** | Status bar with system tray |
| **ghostty** | Terminal emulator |
| **zsh** | Shell with oh-my-zsh |
| **yazi** | Terminal file manager |
| **zen** | Browser (Firefox fork) |
| **git** | Version control (uses GitHub CLI) |
| **clipse** | Clipboard manager |

## Important Keybindings

- `Super + Return` - Open terminal
- `Super + E` - File manager
- `Super + B` - Browser
- `Super + Space` - App launcher
- `Super + V` - Clipboard history
- `Super + Shift + R` - Reload Hyprland

See `hyprland/.config/hypr/hyprland.conf` for all keybindings.

## Bluetooth Management

Bluetooth tray icon is available in Waybar:
- **Left-click** - Quick connect menu
- **Right-click** - Settings and options

## Troubleshooting

### Stow conflicts
```bash
# Backup existing file
mv ~/.<filename> ~/.<filename>.backup

# Retry stow
stow <component>
```

### Bluetooth not working
```bash
# Start/enable bluetooth service
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

# Start blueman applet
blueman-applet &
```

### Hyprland not starting
```bash
# Check greetd service
systemctl status greetd.service

# Verify config
cat /etc/greetd/config.toml
```

## Additional Documentation

- **CLAUDE.md** - Instructions for AI assistants working with this repository
- **Hyprland Wiki** - https://wiki.hyprland.org/
- **Arch Wiki** - https://wiki.archlinux.org/

## System Information

- **OS:** Arch Linux (CachyOS kernel)
- **Display Server:** Wayland
- **Compositor:** Hyprland
- **Login Manager:** greetd + tuigreet
- **Shell:** zsh (oh-my-zsh)
- **Terminal:** ghostty
