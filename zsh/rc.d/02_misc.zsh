mkdir -p "${XDG_DATA_HOME}/zsh"
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# <Docs> man zshzle | less +/Special.Widgets </Docs>
barcursor() { printf '\e[5 q'; }
zle -N zle-line-pre-redraw
zle -N zle-line-init
zle-line-init() { barcursor }
zle-line-pre-redraw() { barcursor }

# <Docs> man zshmisc | less +/SPECIAL.FUNCTIONS </Docs>
autoload session-cd
session-cd load
chpwd() { session-cd save; }

hash -d PREFIX="$PREFIX"

# Removes duplicate entries
typeset -U path cdpath fpath manpath
