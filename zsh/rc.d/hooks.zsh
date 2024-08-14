# <Docs> man zshcontrib | less +/add-zle-hook-widget </Docs>
# <Docs> man zshzle | less +/Special.Widgets </Docs>
autoload add-zle-hook-widget
# <Docs> man zshcontrib | less +/add-zsh-hook </Docs>
# <Docs> man zshmisc | less +/SPECIAL.FUNCTIONS </Docs>
autoload add-zsh-hook

add-zle-hook-widget line-pre-redraw barcursor
add-zle-hook-widget line-init       barcursor
barcursor() {
	print-special barcursor
}

# Set previous PWD and OLDPWD
session-cd load
add-zsh-hook chpwd session-save
session-save() {
	session-cd save
}

add-zsh-hook preexec command-title
add-zsh-hook precmd  directory-title
command-title() {
	print-special title "${1}"
}
directory-title() {
	print-special title "${(D)PWD}"
}
