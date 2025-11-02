# Update and upgrade system

sudo pacman -Syu


# Setup login manager and greeter

sudo pacman -S --needed greetd greetd-tuigreet
sudo systemctl enable greetd.service
sudo cp ./etc/greetd/config.toml /etc/greetd/config.toml

# Setup base tools

sudo pacman -S --needed git stow yay zsh ghostty zen-browser ttf-cascadia-code-nerd github-cli
stow zsh
stow ghostty

# Setup composer

sudo pacman -S --needed hyprland
stow hyprland


# Hyprland must have

sudo pacman -S --needed pipewire wireplumber swaync xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland


# Hyprland nice to have

sudo pacman -S --needed waybar hyprpaper swww hyprpicker yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

yay -S --needed clipse
