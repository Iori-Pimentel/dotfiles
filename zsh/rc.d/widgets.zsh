autoload modify-current-argument

zle -N edit-command-line
autoload edit-command-line

zle -N fzf-file-widget
fzf-file-widget() {
	[[ $LBUFFER[-1] == ' ' ]] || LBUFFER+=' '
	LBUFFER+=$(eval $FZF_DEFAULT_COMMAND | fzf)
	[[ $LBUFFER[-1] == ' ' ]] || LBUFFER+=' '

	zle reset-prompt
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

# Alternative to expand-absolute-path that does not resolve symlinks
# This is done since I prefer ~/storage/downloads (symlink)
# over /storage/emulated/0/Download
zle -N expand-current-path
expand-current-path() {
	modify-current-argument glob-expand-current-path
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

	redraw-prompt
	zle autosuggest-fetch
}
