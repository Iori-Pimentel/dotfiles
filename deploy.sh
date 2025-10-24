#!/bin/bash
# Zsh setup script for Termux-Monet
# https://github.com/HardcodedCat/termux-monet

set -o errexit
PS4='\e[36m deploy.sh:${LINENO} => \e[m'
set -o xtrace

[[ -d ~/storage ]] || termux-setup-storage

# termux-change-repo alternative that defaults to asia mirror group
ln -sfT ${PREFIX}/etc/termux/{mirrors/asia,chosen_mirrors}

pkg upgrade --yes --option Dpkg::Options::="--force-confnew"
packages=(
	zsh git manpages
	eza bat fd ripgrep neovim
	fzf termux-api openssh
	clang  # c compiler for nvim-treesitter
	stylua # formatter used by conform nvim
	lua-language-server # nvim lsp
	fastfetch
	lazygit difftastic
	python uv
	websocat tinymist typst
	rclone
)
pkg install --yes ${packages[@]}

XDG_CONFIG_HOME=~/.config
XDG_CACHE_HOME=~/.cache

DOTFILES=https://github.com/Iori-Pimentel/dotfiles.git
ANTIDOTE=https://github.com/mattmc3/antidote.git

DOTFILES_BASE=${HOME}/.local/dotfiles
ANTIDOTE_BASE=${XDG_CACHE_HOME}/antidote/.antidote

[[ -d ${DOTFILES_BASE}/.git ]] ||
git clone ${DOTFILES} ${DOTFILES_BASE}
[[ -d ${ANTIDOTE_BASE}/.git ]] ||
git clone ${ANTIDOTE} ${ANTIDOTE_BASE} --depth=1

mkdir -p ${XDG_CONFIG_HOME}
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
	--parallel
	--fail
	--location
)
termux=(--output-dir ~/.termux
	# An incomplete font file while the terminal
	# is being written to, will cause a crash.
	$FONT        -o font.ttf.tmp
	$FONT_ITALIC -o font-italic.ttf.tmp
	$COLORS      -o colors.properties
)
curl ${opts[@]} ${termux[@]}

mv ~/.termux/font.ttf{.tmp,}
mv ~/.termux/font-italic.ttf{.tmp,}

termux-reload-settings
touch ~/.hushlogin
nvim --headless "+Lazy! install" +qa > /dev/null

read -p 'Press any key to continue' -n1
clear
chsh -s zsh

PS4='\e[35m [Wait for zsh prompt to show] \e[m'
exec zsh
