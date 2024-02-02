typeset -A key
key=(
	Ctrl      '^'
	Esc       '^['
	Tab       '^I'
	ShiftTab  '^[[Z'
	Enter     '^M'
	CtrlSpace '^@'

	Up             '^[[A'
	Down           '^[[B'
	Left           '^[[D'
	Right          '^[[C'
	CtrlUp         '^[[1;5A'
	CtrlDown       '^[[1;5B'
	CtrlLeft       '^[[1;5D'
	CtrlRight      '^[[1;5C'
	ShiftUp        '^[[1;2A'
	ShiftDown      '^[[1;2B'
	ShiftLeft      '^[[1;2D'
	ShiftRight     '^[[1;2C'
	CtrlShiftUp    '^[[1;6A'
	CtrlShiftDown  '^[[1;6B'
	CtrlShiftLeft  '^[[1;6D'
	CtrlShiftRight '^[[1;6C'

	Backspace     '^?'
	CtrlBackspace '^H'

	Delete          '^[[3~'
	CtrlDelete      '^[[3;5~'
	ShiftDelete     '^[[3;2~'
	CtrlShiftDelete '^[[3;6~'
)

# <Docs> man zshzle | less +/^STANDARD.WIDGETS </Docs>
# History Navigation
bindkey ${key[Up]}       up-line-or-search
bindkey ${key[Down]}     down-line-or-search
bindkey ${key[CtrlDown]} end-of-history
bindkey ${key[Ctrl]}'n'  down-history
bindkey ${key[Ctrl]}'p'  up-history

# Modifying Text
bindkey ${key[Delete]} delete-char

# Misc bindings
bindkey ${key[Esc]}'u'           undo
bindkey ${key[Esc]}${key[Enter]} edit-command-line

# <Docs> man zshcontrib | less +/select-word-style +nn </Docs>
# Movements delimited by shell argements
autoload select-word-style
select-word-style shell # also autoloads all -match functions
bindkey ${key[CtrlBackspace]} backward-kill-word
bindkey ${key[CtrlDelete]}    kill-word
bindkey ${key[CtrlLeft]}      backward-word
bindkey ${key[CtrlRight]}     forward-word

# Movements delimited by [/ ]
zstyle ':zle:*path*' word-style unspecified
zstyle ':zle:*path*' word-chars '/ '
zle -N backward-kill-word-{path,match}
zle -N kill-word-{path,match}
zle -N backward-word-{path,match}
zle -N forward-word-{path,match}
bindkey ${key[Esc]}${key[Backspace]} backward-kill-word-path
bindkey ${key[Esc]}${key[Delete]}    kill-word-path
bindkey ${key[Esc]}${key[Left]}      backward-word-path
bindkey ${key[Esc]}${key[Right]}     forward-word-path

# Replacing plugin keybind
bindkey ${key[Esc]}'g' toggle-directory-history
bindkey -r ${key[Ctrl]}'g'

# Removing bindings on unused keys
bindkey -s ${key[ShiftUp]}        ''
bindkey -s ${key[ShiftDown]}      ''
bindkey -s ${key[ShiftLeft]}      ''
bindkey -s ${key[ShiftRight]}     ''
bindkey -s ${key[CtrlShiftUp]}    ''
bindkey -s ${key[CtrlShiftDown]}  ''
bindkey -s ${key[CtrlShiftLeft]}  ''
bindkey -s ${key[CtrlShiftRight]} ''

bindkey -s ${key[ShiftTab]}        ''
bindkey -s ${key[ShiftDelete]}     ''
bindkey -s ${key[CtrlShiftDelete]} ''

# <Docs> man zshzle | less +/Reading.Commands </Docs>
# Fixes pasting text when <Esc> is active
# Ignores <Esc> if sequence is not bound
# <Esc> timeout defined by KEYTIMEOUT
bindkey -s ${key[Esc]} ''
