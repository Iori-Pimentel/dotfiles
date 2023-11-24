#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet
# TODO: Add error handling

set -e
SCRIPT_DIR=$(dirname "$0")

[[ -d ~/storage ]] ||
  termux-setup-storage

[[ -e ${PREFIX}/etc/termux/chosen_mirrors ]] ||
  termux-change-repo
  # ln -s "${PREFIX}/etc/termux/"{mirrors/asia,chosen_mirrors}

yes | pkg upgrade

packages=(
  zsh git # dependencies
  manpages tealdeer
  eza bat
  neovim fzf
  termux-api
  openssh
) && pkg install -y ${packages[@]}
unset packages

tldr --update
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

DOTFILES="${HOME}/.local/dotfiles"

# git clone https://github.com/Iori-Pimentel/dotfiles.git "${DOTFILES}/dotfiles"
git clone ~/storage/downloads/dotfiles "$DOTFILES"
ln -sf "${DOTFILES}/zsh/.zshenv" ~/.zshenv
git clone --depth=1 https://github.com/mattmc3/antidote.git "${DOTFILES}/zsh/.antidote"

COLORS='https://github.com/adi1090x/termux-style/raw/master/colors/gruvbox-dark.properties'
FONT='https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -fsSL $COLORS $FONT -o ~/.termux/colors.properties -o ~/.termux/font.ttf

# Default XDG paths
XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"

# Required Directories
mkdir -p "${XDG_DATA_HOME}/zsh" # Needed for history file
mkdir -p "${XDG_CONFIG_HOME}/git"

ln -sf "${DOTFILES}/configs/gitconfig" "${XDG_CONFIG_HOME}/git/config"
# scripts
# mkdir -p "~/.local/bin"
# curl -O https://raw.githubusercontent.com/laraib07/androfetch/main/androfetch && chmod u+x androfetch && mv androfetch ~/.local/bin/

chsh -s zsh

echo 'Run pkg install ripgrep-all fd wget curl'
echo 'Restart the terminal using exit to apply zsh'
