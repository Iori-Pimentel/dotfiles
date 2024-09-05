zle -N edit-command-line
autoload edit-command-line

zle -N accept-line
accept-line() {
	[[ "$BUFFER" == *[^[:space:]]* ]] && zle .accept-line
}

# Avoid pasting Ctrl-C, as it interrupts
# the process and breaks pasting functionality.
zle -N bracketed-paste
bracketed-paste() {
	local PASTED
	zle .bracketed-paste PASTED

	PASTED="${(*)PASTED##[[:space:]]#}"
	PASTED="${(*)PASTED%%[[:space:]]#}"

	LBUFFER+="$PASTED"
	[[ "$PASTED" == *$'\n'* ]] && zle edit-command-line
}

zle -N clear-screen
clear-screen() {
	clear # Remove scrollback buffer
}

# Bind widget to <Ctrl-v> (default)
# Fixes <Ctrl-v>bracketed-paste
zle -N quoted-insert
quoted-insert() {
	zle read-command

	if [[ $REPLY == 'bracketed-paste' ]]; then
		zle -U $KEYS
	else
		LBUFFER+=$KEYS
		zle read-input
		LBUFFER+=$REPLY
	fi
}

# Bind widget to <Esc>
# Fixes <Esc>bracketed-paste
# Ignores <Esc>undefined-key
zle -N read-input
read-input() {
	read -t0 -k $(( $KEYS_QUEUED_COUNT + $PENDING ))
}

zle -N fzf-history
fzf-history() {
	zmodload zsh/parameter 2>/dev/null # For history parameter

	# Filter duplicate commands
	local AWK_ARG='{ line=$0; $1=""; if (!seen[$0]++) print line }'

	local FZF_ARGS=(
		--ansi
		--scheme=history
		# Exclude first field in search
		# This allows ^command searches
		# Use --with-nth to hide field
		--nth '2..'
	)

	printf '\n'
	local HISTORY_NUM _
	custom-fc all |
	awk "${AWK_ARG}" |
	fzf "${FZF_ARGS[@]}" | read HISTORY_NUM _
	print-special upline

	zle reset-prompt

	# Those imported by SHARE_HISTORY option
	# end with a * character which we ignore
	HISTORY_NUM=${HISTORY_NUM%[*]}
	(( $#HISTORY_NUM )) || return 1

	local HISTORY_LINE stat
	HISTORY_LINE="$(fetch-history-line $HISTORY_NUM)" stat=$?
	HISTORY_LINE="${HISTORY_LINE%$'\0'}"
	(( stat )) && return $stat

	BUFFER="${HISTORY_LINE}"
	CURSOR=$#BUFFER
}

# <Docs> man zshcompwid | less +/COMPLETION.WIDGET.EXAMPLE </Docs>
# <Docs> man zshcompwid | less +/COMPLETION.SPECIAL.PARAMETERS </Docs>
zle -C fzf-files complete-word fzf-files
fzf-files() {
	local SEARCH_PATH="${PREFIX:-./}" stat
	local MULTI_FZF='--no-multi'
	(( NUMERIC < 0 )) && SEARCH_PATH=./

	[[ "${SEARCH_PATH[-1]}" == '/' ]] || return 1
	if [[ "${compstate[quoting]}" != (single|double) ]]; then
		# eval should be safe to do in this branch
		SEARCH_PATH="$(eval printf '"%s\0"' "$SEARCH_PATH" 2>/dev/null)" stat=$?
		SEARCH_PATH="${SEARCH_PATH%$'\0'}"
		(( stat )) && return $stat

		MULTI_FZF='--multi'
	fi
	[[ "${SEARCH_PATH}" == *$'\0'* ]] && return 1

	(( NUMERIC < 0 )) && MULTI_FZF='--no-multi'

	local FD_ARGS=(
		--print0
		--unrestricted
		--strip-cwd-prefix
		--base-directory="${SEARCH_PATH}"
	)

	local FZF_ARGS=(
		$MULTI_FZF
		--read0
		--no-multi-line
		--print0
		--scheme=path
		--border-label-pos=3
		# Display on border if selection has non-printable character
		--bind='focus:transform-border-label(
			[[ {} == *[^[:print:]]* ]] && printf %q {}
		)'
	)

	printf '\n'
	local FILE_PATH
	FILE_PATH="$(fd "${FD_ARGS[@]}" 2>/dev/null | fzf "${FZF_ARGS[@]}")" stat=$?
	FILE_PATH="${FILE_PATH%$'\0'}"
	print-special upline

	setopt LOCAL_OPTIONS LOCAL_TRAPS
	# Special case for completion widgets:
	# Cannot call zle directly. Must use TRAPEXIT.
	TRAPEXIT() { zle reset-prompt }
	(( stat )) && return $stat

	# This allows selecting multiple FILE_PATH
	FILE_PATH=( "${${(0)FILE_PATH}[@]%/}" )
	compstate[insert]='all'

	# We use -Ui "${PREFIX}" instead of -P "${PREFIX}"
	# since the latter breaks on ~/{ completion
	compadd -Ui "${PREFIX}" -fW "${SEARCH_PATH}" -a FILE_PATH
}
