# Update and upgrade system

sudo pacman -Syu


# Setup login manager and greeter

sudo pacman -S --needed --noconfirm greetd greetd-tuigreet
sudo systemctl enable greetd.service
sudo cp ./etc/greetd/config.toml /etc/greetd/config.toml

# Setup base tools

sudo pacman -S --needed --noconfirm git stow yay zsh ghostty zen-browser ttf-cascadia-code-nerd github-cli
stow zsh
stow ghostty
stow zen

# Setup composer

sudo pacman -S --needed --noconfirm hyprland
stow hyprland


# Hyprland must have

sudo pacman -S --needed --noconfirm pipewire wireplumber swaync xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland


# Hyprland nice to have

sudo pacman -S --needed --noconfirm waybar hyprpaper swww hyprpicker yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

yay -S --needed --noconfirm  clipse
