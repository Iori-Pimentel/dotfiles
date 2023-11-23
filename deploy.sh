#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet
# TODO: Add error handling

SCRIPT_DIR=$(dirname "$0")

[[ -d ~/storage ]] || termux-setup-storage
[[ -e ${PREFIX}/etc/termux/chosen_mirrors ]] || termux-change-repo

yes | pkg upgrade
pkg install -y zsh git fzf manpages bat tealdeer eza neovim
tldr --update
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

DOTFILES="${HOME}/.local/dotfiles"

cp -r ~/storage/downloads/zsh/ "$DOTFILES"
#git clone https://github.com/iori/dotfiles.git "${DOTFILES}/dotfiles"
ln -sf "${DOTFILES}/zsh/.zshenv" ~/.zshenv
git clone --depth=1 https://github.com/mattmc3/antidote.git "${DOTFILES}/zsh/.antidote"

COLORS='https://raw.githubusercontent.com/adi1090x/termux-style/master/colors/gruvbox-dark.properties'
FONT='https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -fsSL $COLORS $FONT -o ~/.termux/colors.properties -o ~/.termux/font.tff

# Required Directories
# Default XDG paths
XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"

mkdir -p "${XDG_DATA_HOME}/zsh" # Needed for history file

# scripts
# mkdir -p "~/.local/bin"
# curl -O https://raw.githubusercontent.com/laraib07/androfetch/main/androfetch && chmod u+x androfetch && mv androfetch ~/.local/bin/

chsh -s zsh

echo 'Run pkg install ripgrep-all fd wget curl'
echo 'Restart the terminal using exit to apply zsh'
