typeset -A key
key=(
	Ctrl           '^'
	Esc            '^['
	Tab            '^I'
	Enter          '^M'
	Backspace      '^?'
	Delete         '^[[3~'
	CtrlBackspace  '^H'
	CtrlDelete     '^[[3;5~'
	CtrlSpace      '^@'

	Up             '^[[A'
	Down           '^[[B'
	Right          '^[[C'
	Left           '^[[D'

	CtrlUp         '^[[1;5A'
	CtrlDown       '^[[1;5B'
	CtrlRight      '^[[1;5C'
	CtrlLeft       '^[[1;5D'

	ShiftUp         '^[[1;2A'
	ShiftDown       '^[[1;2B'
	ShiftRight      '^[[1;2C'
	ShiftLeft       '^[[1;2D'

	CtrlShiftUp     '^[[1;6A'
	CtrlShiftDown   '^[[1;6B'
	CtrlShiftRight  '^[[1;6C'
	CtrlShiftLeft   '^[[1;6D'
)

# <Docs> man zshzle | less '+/^STANDARD WIDGETS' </Docs>
# History Navigation
bindkey  ${key[Up]}             up-line-or-search
bindkey  ${key[Down]}           down-line-or-search
bindkey  ${key[CtrlDown]}       end-of-history
bindkey  ${key[Ctrl]}'n'        down-history
bindkey  ${key[Ctrl]}'p'        up-history

# Modifying Text
bindkey  ${key[Delete]}         delete-char

# Misc bindings
bindkey  ${key[Esc]}'u'         undo
bindkey  ${key[Esc]}${key[Enter]}  edit-command-line

# <Docs> man zshcontrib | less +/select-word-style '+ ' </Docs>
# Movements delimited by shell argements
autoload select-word-style
select-word-style shell # also autoloads all -match functions
bindkey  ${key[CtrlBackspace]}  backward-kill-word
bindkey  ${key[CtrlDelete]}     kill-word
bindkey  ${key[CtrlLeft]}       backward-word
bindkey  ${key[CtrlRight]}      forward-word

# Movements delimited by [/ ]
zstyle ':zle:*path*' word-style unspecified
zstyle ':zle:*path*' word-chars '/ '
zle -N backward-kill-word-{path,match}
zle -N kill-word-{path,match}
zle -N backward-word-{path,match}
zle -N forward-word-{path,match}
bindkey  ${key[Esc]}${key[Backspace]}  backward-kill-word-path
bindkey  ${key[Esc]}${key[Delete]}     kill-word-path
bindkey  ${key[Esc]}${key[Left]}       backward-word-path
bindkey  ${key[Esc]}${key[Right]}      forward-word-path

# Replacing plugin keybind
bindkey -r ${key[Ctrl]}'g'
bindkey  ${key[Esc]}'g' toggle-directory-history

# Removing bindings on unused keys
bindkey  -s ${key[ShiftUp]}       ''
bindkey  -s ${key[ShiftDown]}     ''
bindkey  -s ${key[ShiftRight]}    ''
bindkey  -s ${key[ShiftLeft]}     ''

bindkey  -s ${key[CtrlShiftUp]}       ''
bindkey  -s ${key[CtrlShiftDown]}     ''
bindkey  -s ${key[CtrlShiftRight]}    ''
bindkey  -s ${key[CtrlShiftLeft]}     ''
