autoload modify-current-argument

zle -N edit-command-line
autoload edit-command-line

zle -N accept-line
accept-line() {
	[[ "$BUFFER" =~ '[^[:space:]]' ]] && zle .$WIDGET
}

zle -N bracketed-paste
bracketed-paste() {
	local PASTED TRIMMED
	zle .$WIDGET PASTED
	read -d '' -r TRIMMED <<< "$PASTED"

	LBUFFER+="$TRIMMED"
	[[ "$TRIMMED" =~ $'\n' ]] && zle edit-command-line
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

	redraw-prompt
	zle autosuggest-fetch
}

zle -C fzf-files complete-word fzf-files
fzf-files() {
	emulate -L zsh # for LOCAL_TRAPS: works?
	local SEARCH_PATH FD_ARGS FILE_PATH

	if [[ "${compstate[quoting]}" =~ 'single|double' ]]; then
		SEARCH_PATH=${PREFIX}
	else
		SEARCH_PATH=${~PREFIX}
	fi

	[[ -z "${SEARCH_PATH}" ]] && SEARCH_PATH='./'
	[[ "${SEARCH_PATH[-1]}" != '/' ]] && return 1

	FD_ARGS=(
		--print0
		--hidden
		--strip-cwd-prefix
		--base-directory="${SEARCH_PATH}"
		.
	)

	FILE_PATH="$(fd "${FD_ARGS[@]}" 2>/dev/null | fzf --read0)"
	TRAPEXIT() { zle reset-prompt }

	[[ -z "${FILE_PATH}" ]] && return 1
	compadd -P "${PREFIX}" -fW "${SEARCH_PATH}" -- "${FILE_PATH%/}"
}
