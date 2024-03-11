# <Docs> curl -fsSL https://github.com/romkatv/zsh4humans/raw/v5/fn%2F-z4h-init-zle | nvim +/_z4h_key </Docs>
typeset -A key
key=(
	Ctrl          '^'
	Esc           '^['
	Enter         '^M'
	Backspace     '^?'
	Delete        '^[[3~'
	CtrlBackspace '^H'
	CtrlDelete    '^[[3;5~'
	Tab           '^I'
	ShiftTab      '^[[Z'
	Space         ' '

	Up            '^[[A'
	Down          '^[[B'
	Left          '^[[D'
	Right         '^[[C'
	CtrlLeft      '^[[1;5D'
	CtrlRight     '^[[1;5C'
)

bindkey -A emacs main
bindkey ${key[Esc]} read-input

# <Docs> man zshzle | less +/^STANDARD.WIDGETS </Docs>
# History Navigation
bindkey ${key[Up]}       up-line-or-search
bindkey ${key[Down]}     down-line-or-search
bindkey ${key[Ctrl]}'n'  down-history
bindkey ${key[Ctrl]}'p'  up-history

# Deleting text
bindkey ${key[Delete]}  delete-char
bindkey ${key[Ctrl]}'u' kill-buffer

# Misc bindings
bindkey ${key[Esc]}'u' undo
bindkey ${key[ShiftTab]} fzf-files
bindkey ${key[Esc]}${key[Enter]} edit-command-line

# <Docs> man zshcontrib | less +/select-word-style +nn </Docs>
# Movements delimited by shell arguments
autoload select-word-style
select-word-style shell # also autoloads all -match functions
bindkey ${key[CtrlBackspace]} backward-kill-word
bindkey ${key[CtrlDelete]}    kill-word
bindkey ${key[CtrlLeft]}      backward-word
bindkey ${key[CtrlRight]}     forward-word

# Movements delimited by [/]
zstyle ':zle:*path*' word-style unspecified
zstyle ':zle:*path*' word-chars '/'
zle -N backward-kill-word-{path,match}
bindkey ${key[Esc]}${key[Backspace]} backward-kill-word-path

# Replacing plugin keybind
bindkey ${key[Esc]}'g' toggle-directory-history
bindkey -r ${key[Ctrl]}'g'
