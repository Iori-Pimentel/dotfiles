barcursor() { echo -ne '\e[5 q'; }
autoload redraw-prompt


# <Docs> man zshzle | less '+/Special Widgets' '+/zle-line' </Docs>
zle-line-init() { barcursor }
zle-line-pre-redraw() { barcursor } # fix for edit-command-line widget
# zle-line-pre-redraw() { barcursor; _zsh_highlight; -fast-highlight-init } # fix for edit-command-line widget

zle -N zle-line-pre-redraw
zle -N zle-line-init
