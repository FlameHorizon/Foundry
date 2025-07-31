# 🛠️ Ubuntu Setup Script

This Bash script automates the setup of a development environment on a fresh Ubuntu installation.

## ✅ Features

- Adds PPAs for:
  - .NET SDK via `dotnet/backports`
  - OBS via via `obsproject/obs-studio`
  - Updates and upgrades system packages

- Installs common dev tools:
  - `curl`, `git`, `ripgrep`, `make`, `gcc`, `unzip`, `xclip`, `docker-ce`
  - `dotnet-sdk-9.0`, `VS Code`, `virtualbox`, `python3.12-venv`, `dbeaver`, `rider`

- Install common utilities:
 - `spotify`, `obs-studio`, `vlc`, `thunderbird`

- Installs **Neovim 0.11.0 manually* (APT version is too old)

- Installs and configures:
  - fzf (fuzzy finder)
  - Nerd Fonts (Hermit)
  - Google Chrome
  - git credential helper

- Applies GNOME customizations:
  - Installs rofi
  - Enables dark theme system-wide
  - Disables Ubuntu Dock
  - Sets workspace switching shortcuts to Super + 1..9
  - Fixes number of GNOME workspaces to 6

## 📁 Requirements

The only requirement here is that You run this script on Ubuntu 24.04. Other
system were not tested.

# 🧪 Usage

Run the script with:
```bash
sudo ./foundry.sh
```

⚠️ The script uses `sudo` – you’ll need admin privileges.
