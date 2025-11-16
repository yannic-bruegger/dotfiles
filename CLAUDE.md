# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing an Arch Linux desktop environment using **Hyprland** (Wayland compositor) and **GNU Stow** for symlink management. The repository contains modular configuration for development tools, desktop applications, and system components.

## Setup and Installation

### Bootstrap the Environment

Run the setup script to install all packages and create symlinks:

```bash
./setup.sh
```

This script:
1. Updates the system with `pacman -Syu`
2. Installs greetd login manager and copies system config to `/etc/greetd/config.toml`
3. Installs base tools (git, zsh, nvim, ghostty, zen-browser, claude-code, etc.)
4. Installs Hyprland and its ecosystem (waybar, swww, hypridle, hyprlock, etc.)
5. Installs AUR packages via yay (clipse, bibata-cursor-theme-bin)
6. Creates symlinks using stow for each component

### Managing Dotfiles with Stow

Each directory represents a "package" that can be independently stowed:

```bash
# Install a specific component's dotfiles
stow <directory-name>

# Example: Install zsh configuration
stow zsh

# Remove/uninstall a component's symlinks
stow -D <directory-name>

# Restow (useful after adding new files)
stow -R <directory-name>
```

**Important**: Run stow commands from the `/home/yannic/dotfiles` directory.

### Directory Structure Pattern

Each stow package maintains the full path hierarchy under its own directory:
- `zsh/.zshrc` → symlinks to `~/.zshrc`
- `ghostty/.config/ghostty/config` → symlinks to `~/.config/ghostty/config`
- `hyprland/.config/hypr/hyprland.conf` → symlinks to `~/.config/hypr/hyprland.conf`

## Key Components

| Component | Purpose | Main Config Files |
|-----------|---------|-------------------|
| **zsh** | Shell with oh-my-zsh | `.zshrc` |
| **git** | Version control | `.gitconfig` (uses GitHub CLI for auth) |
| **hyprland** | Window manager/compositor | `hyprland.conf`, `hypridle.conf`, `hyprlock.conf` |
| **ghostty** | Terminal emulator | `config` |
| **waybar** | Status bar | `config.jsonc`, `style.css` |
| **yazi** | File manager (CLI) | `yazi.toml` |
| **clipse** | Clipboard manager | `config.json` |
| **claude** | Claude Code CLI | `.claude.json`, MCP server configs |
| **zen** | Browser (Firefox fork) | Profile data in `.zen/` |
| **etc** | System configs | `greetd/config.toml` |

## Common Development Tasks

### Modifying Configurations

When editing configuration files:

1. **Always edit the files in the dotfiles repository**, not the symlinked versions in `~`
2. Changes take effect immediately for most applications (no need to restow)
3. For Hyprland changes, reload with `Super + Shift + R` or restart Hyprland

### Testing Configuration Changes

Before committing changes to critical configs like hyprland:

```bash
# Test Hyprland config syntax
hyprctl reload

# Check waybar config
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```

### Adding New Components

To add a new tool's configuration:

1. Create a new directory: `mkdir <tool-name>`
2. Add config files with full path: `<tool-name>/.config/<tool-name>/config`
3. Stow the new package: `stow <tool-name>`
4. Add the stow command to `setup.sh` for future installations
5. Add the package installation command to `setup.sh` if needed

## Architecture Notes

### Hyprland Workflow

Key applications and bindings are defined in `hyprland/.config/hypr/hyprland.conf`:

- **Terminal**: `ghostty` (variable: `$terminal`)
- **File Manager**: `yazi` (variable: `$fileManager`)
- **Launcher**: `hyprlauncher` (variable: `$menu`)
- **Clipboard Manager**: `clipse` (bound to `Super + V`)

Autostart processes (in `exec-once` blocks):
- `hyprpolkitagent` - Authentication agent
- `waybar` - Status bar
- `clipse -listen` - Clipboard daemon
- `~/dotfiles/hyprland/swww.sh` - Wallpaper manager script
- `hypridle` - Idle/lock manager

### Git Credential Management

Git uses GitHub CLI for credential handling (see `git/.gitconfig`):

```ini
[credential "https://github.com"]
  helper = !/usr/bin/gh auth git-credential
```

To authenticate: `gh auth login`

### Files Not Tracked in Git

The following are intentionally ignored (runtime/cache/session data):
- `.claude/debug/` - Debug logs
- `.claude/shell-snapshots/` - Shell state
- `.claude/todos/` - Session todos
- `.zen/` runtime data (SQLite DBs, cookies, cache)
- `clipse/.config/clipse/clipboard_history.json` - Clipboard history

### Theme and Styling

- **Cursor Theme**: Bibata-Modern-Classic (24px)
- **Waybar**: Custom CSS styling in `waybar/.config/waybar/style.css`
- **Terminal**: Ghostty with minimal config (relies on defaults)
- **Shell**: oh-my-zsh with robbyrussell theme

## Package Management

### Installing Packages

```bash
# Official repository packages
sudo pacman -S <package-name>

# AUR packages
yay -S <package-name>

# Updating the system
sudo pacman -Syu
```

### Key Dependencies

All required packages are listed in `setup.sh`. Core dependencies include:
- **Wayland/Hyprland**: hyprland, xdg-desktop-portal-hyprland, qt5-wayland, qt6-wayland
- **Audio**: pipewire, wireplumber
- **CLI Tools**: fd, ripgrep, fzf, zoxide, yazi, jq
- **Development**: git, github-cli, nvim, claude-code

## Troubleshooting

### Stow Conflicts

If stow fails with "conflicts" error:
```bash
# Check what's blocking the symlink
ls -la ~/.<filename>

# Backup the existing file if needed
mv ~/.<filename> ~/.<filename>.backup

# Retry stow
stow <component>
```

### Hyprland Not Starting

Check greetd service status:
```bash
systemctl status greetd.service
```

Verify `/etc/greetd/config.toml` points to tuigreet with Hyprland command.

### System Configuration Files

The `etc/` directory contains system-level configs that need to be manually copied:
```bash
sudo cp ./etc/greetd/config.toml /etc/greetd/config.toml
```
