#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet

set -o errexit
PS4='\e[36m deploy.sh:${LINENO} => \e[m'
set -o xtrace

[[ -d ~/storage ]] || termux-setup-storage

# termux-change-repo alternative that defaults to asia mirror group
ln -sfT ${PREFIX}/etc/termux/{mirrors/asia,chosen_mirrors}

pkg upgrade --yes
packages=(
	zsh git manpages
	eza bat fd ripgrep neovim
	fzf termux-api openssh
	clang  # c compiler for nvim-treesitter
	stylua # formatter used by conform nvim
	fastfetch
)
pkg install --yes ${packages[@]}

XDG_CONFIG_HOME=~/.config
 XDG_CACHE_HOME=~/.cache
 XDG_STATE_HOME=~/.local/state
  XDG_DATA_HOME=~/.local/share

DOTFILES=https://github.com/Iori-Pimentel/dotfiles.git
ANTIDOTE=https://github.com/mattmc3/antidote.git

DOTFILES_BASE=${HOME}/.local/dotfiles
ANTIDOTE_BASE=${XDG_CACHE_HOME}/antidote/.antidote

[[ -d ${DOTFILES_BASE}/.git ]] ||
git clone ${DOTFILES} ${DOTFILES_BASE}
[[ -d ${ANTIDOTE_BASE}/.git ]] ||
git clone ${ANTIDOTE} ${ANTIDOTE_BASE} --depth=1

ln -sf ${DOTFILES_BASE}/zsh/.zshenv --target-directory ${HOME}
ln -sf ${DOTFILES_BASE}/configs/*   --target-directory ${XDG_CONFIG_HOME}

cat <<- 'EOF' > ~/.termux/termux.properties
	# Example file can be found in:
	# ${PREFIX}/share/examples/termux/termux.properties

	extra-keys = []
	back-key = escape
	fullscreen = true
EOF

FONT=https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
FONT_ITALIC=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FJetBrainsMono%2FNoLigatures%2FItalic%2FJetBrainsMonoNLNerdFont-Italic.ttf
COLORS=https://github.com/adi1090x/termux-style/raw/master/colors/gruvbox-dark.properties
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
curl --parallel ${opts[@]} ${termux[@]}

termux-reload-settings
touch ~/.hushlogin
nvim --headless "+Lazy! install" +qa

read -p 'Press any key to continue' -n1
clear && chsh -s zsh && exec zsh
