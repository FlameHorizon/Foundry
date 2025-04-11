#!/bin/bash

# For dotnet, we are using PiPiAye (PPA)
sudo add-apt-repository -y ppa:dotnet/backports

# This PPA is for ulauncher
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:agornostal/ulauncher -y

# Before doing anything else, ALWAYS update current packages.
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade

packages=(
  curl=8.5.0-2ubuntu10.6
  git=1:2.43.0-1ubuntu7.2
  ripgrep=14.1.0-1
  make
  gcc
  unzip
  xclip
  dotnet-sdk-9.0
  alacritty
  chrome-gnome-shell
  ulauncher
)

for pkg in "${packages[@]}"; do
  base_pkg=$(echo "$pkg" | cut -d= -f1)

  if dpkg -s "$base_pkg" &> /dev/null; then
    echo "Package '$base_pkg' is already installed. Skipping..."
  else
    echo "Installing '$pkg'..."
    sudo apt-get install --assume-yes "$pkg"
  fi
done

# Some packages can't be installed from APT with wanted version because
# they are not available yet. Such example is neovim where APT version 
# is 0.9.5 but features I'm using require version 0.11.0.
# For this reason, I have to download binaries manually, extract them
# and add path to the binary manually.

if [ ! -d /opt/nvim-linux-x86_64/ ] ; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  rm nvim-linux-x86_64.tar.gz
  
  # Neovim configuration - kickstart
  git clone https://github.com/FlameHorizon/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
else
  echo "Neovim is already installed. Skipping..."
fi

if [ ! -e /home/flm/.fzf/bin/fzf ] ; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "Fzf is already installed. Skipping..."
fi

# Download and install fonts if they are not there.
# Prepare location where fonts will be installed.
if [ ! -d ~/.fonts/ ] ; then
  mkdir ~/.fonts

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hermit.zip

  unzip Hermit.zip -d ~/.fonts
  fc-cache -f -v
  rm Hermit.zip
else
  echo "Fonts is already installed. Skipping..."
fi

# Install Google Chrome from .deb package.
if [ ! -e /usr/bin/google-chrome ] ; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
else
  echo "Google Chrome is already installed. Skipping..."
fi

sudo snap install spotify

# At this point, installation portion is completed. Now it is time to configure.
# Alacritty needs everforest theme.

if [ ! -d ~/.config/alacritty ] ; then
  mkdir -p ~/.config/alacritty
  cp alacritty.toml ~/.config/alacritty/alacritty.toml
else
  echo "Alacritty is already installed. Skipping..."
fi

# Once alacritty is installed, change default terminal in GNOME.
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# Update ulauncher settings
# Start ulauncher to have it populate config before we overwrite
if [ ! -d ~/.config/autostart/ ] ; then
  mkdir -p ~/.config/autostart/
  cp ulauncher.desktop ~/.config/autostart/ulauncher.desktop
  gtk-launch ulauncher.desktop >/dev/null 2>&1
  sleep 2 # ensure enough time for ulauncher to set defaults
  cp ulauncher.json ~/.config/ulauncher/settings.json
else
  echo "Ulauncher is already installed. Skipping..."
fi

# Set dark mode in GNOME
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# Disable dock but not remove it entirely
gnome-extensions disable ubuntu-dock@ubuntu.com

# Sets workspaces shortcut.
# NOTE: I've tried to map workspace to <Super>+1 but it collides with the dock.
for i in {1..9}; do 
  gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Alt>$i']" ; 
done

# Set static number of workspaces to 6 without ability to expand.
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6
