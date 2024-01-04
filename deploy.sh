#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet

set -o errexit

[[ -d ~/storage ]] || termux-setup-storage

# termux-change-repo alternative that defaults to asia mirror group
ln -sfT "${PREFIX}/etc/termux/"{mirrors/asia,chosen_mirrors}

pkg upgrade -y
packages=(
	zsh git
	manpages tealdeer
	eza bat
	fd ripgrep
	neovim fzf
	termux-api
	openssh
	shellcheck
	clang  # c compiler for nvim-treesitter
	stylua # formatter used by conform nvim
	shfmt  # formatter not used by conform nvim
)
pkg install -y "${packages[@]}"
unset packages

# Default XDG paths
XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"

directories=(
	"${XDG_DATA_HOME}/zsh" # for zsh HISTFILE
	"${XDG_CONFIG_HOME}/git"
	"${HOME}/.local/bin"
)
mkdir --parents "${directories[@]}"
unset directories

DOTFILES="${HOME}/.local/dotfiles"
git clone https://github.com/Iori-Pimentel/dotfiles.git "${DOTFILES}"
git clone https://github.com/mattmc3/antidote.git       "${DOTFILES}/zsh/.antidote" --depth=1

args=(--symbolic --force --no-target-directory)
ln "${args[@]}" "${DOTFILES}/zsh/.zshenv"       "${HOME}/.zshenv"
ln "${args[@]}" "${DOTFILES}/configs/gitconfig" "${XDG_CONFIG_HOME}/git/config"
ln "${args[@]}" "${DOTFILES}/nvim"              "${XDG_CONFIG_HOME}/a-nvim"
unset args

COLORS='https://github.com/adi1090x/termux-style/raw/master/colors/gruvbox-dark.properties'
FONT='https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
FONT_ITALIC='https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FJetBrainsMono%2FNoLigatures%2FItalic%2FJetBrainsMonoNLNerdFont-Italic.ttf'
ANDROFETCH='https://github.com/laraib07/androfetch/raw/main/androfetch'

args=(
	--fail
	--location # follow 3xx response code
	--silent --show-error # disables progress meter but still show error messages
	"$COLORS"      -o ~/.termux/colors.properties
	"$FONT"        -o ~/.termux/font.ttf
	"$FONT_ITALIC" -o ~/.termux/font-italic.ttf
	"$ANDROFETCH"  -o ~/.local/bin/androfetch
)
curl "${args[@]}"
unset args

chmod u+x ~/.local/bin/androfetch

tldr --update
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
chsh -s zsh

echo 'Run command when pushing to github:'
echo 'git remote set-url origin git@github.com:Iori-Pimentel/dotfiles.git'
echo 'Restart the app to continue'
