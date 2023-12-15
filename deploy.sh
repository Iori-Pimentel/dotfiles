#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet

set -e

[[ -d ~/storage ]] || termux-setup-storage

# termux-change-repo alternative that defaults to asia mirror group
ln -sfT "${PREFIX}/etc/termux/"{mirrors/asia,chosen_mirrors}

pkg upgrade -y
packages=(
  zsh git # dependencies
  manpages tealdeer
  eza bat
  fd ripgrep
  neovim fzf
  termux-api
  openssh
  shellcheck
  clang # c compiler for nvim-treesitter 
  lua-language-server # mason-lspconfig replacement for lua
  python # nvim-jdtls dependencies
) && pkg install -y ${packages[@]}

# Default XDG paths
XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"

# Required Directories
mkdir -p "${XDG_DATA_HOME}/zsh" # Needed for history file
mkdir -p "${XDG_CONFIG_HOME}/git"
mkdir -p "${HOME}/.local/bin"


DOTFILES="${HOME}/.local/dotfiles"

git clone https://github.com/Iori-Pimentel/dotfiles.git  "${DOTFILES}"
git clone https://github.com/mattmc3/antidote.git        "${DOTFILES}/zsh/.antidote" --depth=1

ln -sfT "${DOTFILES}/zsh/.zshenv"        ~/.zshenv
ln -sfT "${DOTFILES}/configs/gitconfig"  "${XDG_CONFIG_HOME}/git/config"
ln -sfT "${DOTFILES}/nvim"               "${XDG_CONFIG_HOME}/a-nvim"

COLORS='https://github.com/adi1090x/termux-style/raw/master/colors/gruvbox-dark.properties'
FONT='https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
FONT_ITALIC='https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FJetBrainsMono%2FNoLigatures%2FItalic%2FJetBrainsMonoNLNerdFont-Italic.ttf'

curl -fsSL $COLORS $FONT $FONT_ITALIC -o ~/.termux/colors.properties -o ~/.termux/font.ttf -o ~/.termux/font-italic.ttf

ANDROFETCH='https://github.com/laraib07/androfetch/raw/main/androfetch'
BIN_DIR="${HOME}/.local/bin"

mv-bin() { chmod u+x "$@" && mv "$@" "$BIN_DIR"; }
curl -fsSL -O $ANDROFETCH && mv-bin androfetch

# scripts

tldr --update
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
chsh -s zsh

echo 'Run command when pushing to github:'
echo 'git remote set-url origin git@github.com:Iori-Pimentel/dotfiles.git'
echo 'Restart the app to continue'
