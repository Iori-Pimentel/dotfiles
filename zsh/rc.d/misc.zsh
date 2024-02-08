mkdir -p "${XDG_DATA_HOME}/zsh"
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

hash -d PREFIX="$PREFIX"

# Removes duplicate entries
typeset -U path cdpath fpath manpath
