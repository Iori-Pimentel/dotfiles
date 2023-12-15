# WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
WORDCHARS+=':"\|'
WORDCHARS+=\'
WORDCHARS=$(tr -d '/' <<< "$WORDCHARS")
# WORDCHARS='*?_-.[]~=&;!#$%^(){}<>:"\|'\'

typeset -A key
key=(
	Up             '^[[A'
	Down           '^[[B'
	Right          '^[[C'
	Left           '^[[D'

	CtrlUp         '^[[1;5A'
	CtrlDown       '^[[1;5B'
	CtrlRight      '^[[1;5C'
	CtrlLeft       '^[[1;5D'

	Backspace      '^?'
	Delete         '^[[3~'
	CtrlBackspace  '^H'
	CtrlDelete     '^[[3;5~'
	CtrlSpace      '^@'

	Esc            '^['
	Enter          '^M'
	Ctrl           '^'
)

# [Docs]
# man zshzle | less -i '+/^standard widgets'
bindkey ${key[Up]} up-line-or-search
bindkey ${key[Down]} down-line-or-search
bindkey ${key[CtrlLeft]} emacs-backward-word
bindkey ${key[CtrlRight]} emacs-forward-word
bindkey ${key[CtrlDown]} end-of-history
bindkey ${key[CtrlBackspace]} backward-kill-word
bindkey ${key[CtrlDelete]} kill-word
bindkey ${key[Delete]} delete-char
bindkey ${key[Ctrl]}'u' vi-kill-line
bindkey ${key[Ctrl]}'a' beginning-of-line #change
bindkey ${key[Ctrl]}'e' end-of-line #change
bindkey ${key[Ctrl]}'n' down-history
bindkey ${key[Ctrl]}'p' up-history
bindkey ${key[Esc]}'u' undo



bindkey ${key[Esc]}${key[Enter]} edit-command-line
bindkey ${key[Esc]}'g' toggle-directory-history

# Removing keybinds
[[ -z $PER_DIRECTORY_HISTORY_TOGGLE ]] || bindkey -r $PER_DIRECTORY_HISTORY_TOGGLE
# bindkey -r ${key[Ctrl]}'s'
