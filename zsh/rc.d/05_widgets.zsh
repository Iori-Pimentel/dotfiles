autoload modify-current-argument

zle -N edit-command-line
autoload edit-command-line

# <Docs> man zshexpn | less +/Parameter.Expansion.Flags '+/ (D|~)' </Docs>
expand-path() {
	FILE=${~1} # expands argument
	[[ -e $FILE ]] || return 1

	# preserves symbolic directory of $FILE
	[[ ${FILE} == /* ]] || FILE=$PWD/$FILE
	# resolves ../. components
	FILE=$(realpath -s ${FILE})
	# converts absolute path to ~/
	REPLY=${(D)FILE}
}

zle -N expand-current-path
expand-current-path() {
	modify-current-argument expand-path
}

zle -N accept-line
accept-line() {
	[[ "$BUFFER" =~ '[^[:space:]]' ]] && zle .$WIDGET
}

zle -N bracketed-paste
bracketed-paste() {
	local pasted trimmed
	zle .$WIDGET pasted
	read -d '' -r trimmed <<< "$pasted"

	LBUFFER+="$trimmed"
	[[ "$trimmed" =~ $'\n' ]] && zle edit-command-line
}

zle -N clear-screen
clear-screen() {
	clear # removes scrollback buffer
}

# Fixes pasting text for <Ctrl-v>
zle -N quoted-insert
quoted-insert() {
	zle read-command

	if [[ $REPLY == 'bracketed-paste' ]];then
		zle -U $KEYS # starts bracketed-paste
		return
	fi

	zle read-input VALUE
	LBUFFER+=$KEYS$VALUE
}

# Fixes pasting text for <Esc>
zle -N read-input
read-input() {
	local args=(
		-t 0
		-k $(( $KEYS_QUEUED_COUNT + 1 ))
	)
	read ${args[@]} $1
}

# <Docs> () { nvim +/function.$1 $(antidote path jimhester/$1)/$1.zsh } per-directory-history </Docs>
# Addressed issue with per-directory-history-toggle-history creating a new
# prompt at each call; resolved by copying the source code and removing zle -I.
zle -N toggle-directory-history
toggle-directory-history() {
	if [[ $_per_directory_history_is_global == true ]]; then
		_per-directory-history-set-directory-history
		_per_directory_history_is_global=false
	else
		_per-directory-history-set-global-history
		_per_directory_history_is_global=true
	fi

	autoload redraw-prompt && redraw-prompt
	zle autosuggest-fetch
}
