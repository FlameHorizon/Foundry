# 🛠️ Ubuntu Setup Script

This Bash script automates the setup of a development environment on a fresh Ubuntu installation.

## ✅ Features

- Adds PPAs for:
  - .NET SDK via `dotnet/backports`
  - Ulauncher via `agornostal/ulauncher`
  - Updates and upgrades system packages

- Installs common dev tools:
  - `curl`, `git`, `ripgrep`, `make`, `gcc`, `unzip`, `xclip`
  - `dotnet-sdk-9.0`, `alacritty`, `chrome-gnome-shell`, `ulauncher`, `VS Code`

- Install common utilities:
 - `spotify`

- Installs **Neovim 0.11.0 manually* (APT version is too old)

- Installs and configures:
  - fzf (fuzzy finder)
  - Nerd Fonts (Hermit)
  - Google Chrome
  - git credential helper

- Applies GNOME customizations:
  - Sets Alacritty as default terminal
  - Installs and configures Ulauncher
  - Enables dark theme system-wide
  - Disables Ubuntu Dock
  - Sets workspace switching shortcuts to Super + 1..9
  - Fixes number of GNOME workspaces to 6

## 📁 Requirements

Make sure the following files are present in the same directory as the script:
  - `alacritty.toml` – configuration file for Alacritty
  - `ulauncher.desktop` – autostart entry for Ulauncher
  - `ulauncher.json` – preconfigured Ulauncher settings

# 🧪 Usage

Run the script with:
```
bash ./foundry.sh
```

⚠️ The script uses `sudo` – you’ll need admin privileges.
