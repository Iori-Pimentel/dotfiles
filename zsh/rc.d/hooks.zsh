# <Docs> man zshcontrib | less +/add-zle-hook-widget </Docs>
# <Docs> man zshzle | less +/Special.Widgets </Docs>
autoload add-zle-hook-widget

zle -N barcursor
add-zle-hook-widget line-init       barcursor
add-zle-hook-widget line-pre-redraw barcursor
barcursor() {
	printf '\e[5 q' > $TTY
}

# <Docs> man zshcontrib | less +/add-zsh-hook </Docs>
# <Docs> man zshmisc | less +/SPECIAL.FUNCTIONS </Docs>
autoload add-zsh-hook

add-zsh-hook chpwd session-save
session-save() {
	session-cd save
}

# Called only once per session
session-cd load

add-zsh-hook preexec command-title
command-title() {
	BUFFER="$1"
	set-title "$BUFFER"
}

add-zsh-hook precmd directory-title
directory-title() {
	set-title "${(D)PWD}"
}
