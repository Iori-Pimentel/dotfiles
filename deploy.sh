#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet

set -o errexit

[[ -d ~/storage ]] || termux-setup-storage

# termux-change-repo alternative that defaults to asia mirror group
ln -sfT ${PREFIX}/etc/termux/{mirrors/asia,chosen_mirrors}

pkg upgrade -y
packages=(
	zsh git manpages tealdeer
	eza bat fd ripgrep neovim
	fzf termux-api openssh shellcheck
	clang  # c compiler for nvim-treesitter
	stylua # formatter used by conform nvim
	shfmt  # formatter not used by conform nvim
	# nmap # networking tool
	# lsof # list open files (already installed)
)
pkg install -y ${packages[@]}

XDG_CONFIG_HOME=~/.config
 XDG_CACHE_HOME=~/.cache
 XDG_STATE_HOME=~/.local/state
  XDG_DATA_HOME=~/.local/share

DATA=$XDG_DATA_HOME
CONF=$XDG_CONFIG_HOME
CACHE=$XDG_CACHE_HOME
BASE=~/.local/dotfiles

DOTFILES=https://github.com/Iori-Pimentel/dotfiles.git
ANTIDOTE=https://github.com/mattmc3/antidote.git

git clone $DOTFILES ${BASE}
git clone $ANTIDOTE ${BASE}/zsh/.antidote --depth=1

mkdir -p ${CONF}/git
ln -sfT ${BASE}/zsh/.zshenv       ${HOME}/.zshenv
ln -sfT ${BASE}/configs/gitconfig ${CONF}/git/config
ln -sfT ${BASE}/nvim              ${CONF}/nvim

cat <<- 'EOF' > ~/.termux/termux.properties
	# Example file can be found in:
	# ~/../usr/share/examples/termux/termux.properties

	extra-keys = []
	back-key = escape
	fullscreen = true
EOF

FONT=https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
FONT_ITALIC=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FJetBrainsMono%2FNoLigatures%2FItalic%2FJetBrainsMonoNLNerdFont-Italic.ttf
COLORS=https://github.com/adi1090x/termux-style/raw/master/colors/gruvbox-dark.properties
ANDROFETCH=https://github.com/laraib07/androfetch/raw/main/androfetch
opts=(
	--fail # failed response is not saved
	--location # follow 3xx response
	--continue-at - # fixes crash caused by ~/.termux/font.ttf
)
termux=(--output-dir ~/.termux
	$FONT        -o font.ttf
	$FONT_ITALIC -o font-italic.ttf
	$COLORS      -o colors.properties
)
bin=(--output-dir ${PREFIX}/bin
	$ANDROFETCH -o androfetch
)
args=(--parallel
	${opts[@]} ${termux[@]}
	--next
	${opts[@]} ${bin[@]}
)
curl ${args[@]}

chmod u+x ${PREFIX}/bin/androfetch
# Increases color0 contrast with background
sed --in-place 's/color0.*/color0:  #787878/' ~/.termux/colors.properties

tldr --update
termux-reload-settings
touch ~/.hushlogin
clear && chsh -s zsh && exec zsh

# Run command when pushing to github:
# git remote set-url origin git@github.com:Iori-Pimentel/dotfiles.git
