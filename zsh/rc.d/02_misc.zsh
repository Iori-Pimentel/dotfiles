mkdir -p "${XDG_DATA_HOME}/zsh"
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000
barcursor() { echo -ne '\e[5 q'; }
autoload redraw-prompt


# <Docs> man zshzle | less '+/Special Widgets' '+/zle-line' </Docs>
zle-line-init() { barcursor }
zle-line-pre-redraw() { barcursor } # fix for edit-command-line widget
# zle-line-pre-redraw() { barcursor; _zsh_highlight; -fast-highlight-init } # fix for edit-command-line widget

zle -N zle-line-pre-redraw
zle -N zle-line-init
# paths should be canonical
hash -d prefix="$PREFIX"
hash -d downloads="${HOME}/storage/downloads"
autoload -Uz compinit && compinit
source "${PREFIX}/share/fzf/key-bindings.zsh"
# Force path arrays to have unique values only
typeset -U path cdpath fpath manpath
