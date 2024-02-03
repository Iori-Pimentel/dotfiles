# History ----------
mkdir -p "${XDG_DATA_HOME}/zsh"
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# cd into last exited directory
autoload session-cd && {
	session-cd load
	TRAPEXIT() { session-cd save; }
}

# Bar Cursor ----------
# <Docs> man zshzle | less +/Special.Widgets +/zle-line </Docs>
barcursor() { echo -ne '\e[5 q'; }
autoload redraw-prompt
zle-line-init() { barcursor }
zle-line-pre-redraw() { barcursor } # fix for edit-command-line widget
# zle-line-pre-redraw() { barcursor; _zsh_highlight; -fast-highlight-init } # fix for edit-command-line widget
zle -N zle-line-pre-redraw
zle -N zle-line-init

# Hash Directories ----------
hash -d prefix="$PREFIX"
hash -d downloads="${HOME}/storage/downloads"

# Completions ----------
autoload -Uz compinit && compinit

# Fzf Keybindings ----------
source "${PREFIX}/share/fzf/key-bindings.zsh"

# Force path arrays to have unique values only
typeset -U path cdpath fpath manpath
