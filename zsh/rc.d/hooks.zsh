# <Docs> man zshzle | less +/Special.Widgets </Docs>
barcursor() { printf '\e[5 q'; }
zle -N zle-line-init
zle -N zle-line-pre-redraw
zle-line-init() { barcursor }
zle-line-pre-redraw() { barcursor }

session-cd load

# <Docs> man zshmisc | less +/SPECIAL.FUNCTIONS </Docs>
chpwd() {
	session-cd save
}

# https://github.com/jimhester/per-directory-history/issues/31
# Not using preexec() since $1 is empty caused by per-directory-history
zshaddhistory() {
	local title=$1
	# squeeze consecutive newlines
	title=$(tr -s '\n' <<< "$title")
	# remove trailing newlines
	title=${title%%$'\n'}
	# convert $'\n' to '; '
	title=${title//$'\n'/; }

	printf '\e]2;%s\a' ${title} > $TTY
}

precmd() {
	printf '\e]2;%s\a' "${(D)PWD}" > $TTY
}

