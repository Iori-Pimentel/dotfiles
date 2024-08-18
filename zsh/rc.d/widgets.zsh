zle -N edit-command-line
autoload edit-command-line

zle -N accept-line
accept-line() {
	[[ "$BUFFER" =~ '[^[:space:]]' ]] && zle .accept-line
}

# Avoid pasting Ctrl-C, as it interrupts
# the process and breaks pasting functionality.
zle -N bracketed-paste
bracketed-paste() {
	local PASTED
	zle .bracketed-paste PASTED

	setopt LOCAL_OPTIONS EXTENDED_GLOB
	PASTED="${PASTED##[[:space:]]#}"
	PASTED="${PASTED%%[[:space:]]#}"

	LBUFFER+="$PASTED"
	[[ "$PASTED" =~ $'\n' ]] && zle edit-command-line
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
	print-special downline

	{
	while true; do
		history-list-fzf --no-clear | read HISTORY_NUM _

		# Those imported by SHARE_HISTORY option
		# end with a * character which we ignore
		HISTORY_NUM=${HISTORY_NUM%%[*]}

		if [[ $HISTORY_NUM == toggle ]]
		then zle toggle-history-list
		elif (( $HISTORY_NUM ))
		then break; else return
		fi
	done
	} always {
		print-special upline
		zle reset-prompt
	}

	# Fixes the problem of fc having output even with empty history
	(( $#history > 0 )) || return

	# Updating HISTNO updates the BUFFER using a
	# history list that includes edits
	# which doesn't match with fc so we use
	# ${history[$HISTORY_NUM]} which matches
	HISTNO="$HISTORY_NUM"
	BUFFER="${history[$HISTORY_NUM]}"
	CURSOR="$#BUFFER"
}

# <Docs> man zshcompwid | less +/COMPLETION.WIDGET.EXAMPLE </Docs>
# <Docs> man zshcompwid | less +/COMPLETION.SPECIAL.PARAMETERS </Docs>
zle -C fzf-files complete-word fzf-files
fzf-files() {
	local SEARCH_PATH="${PREFIX:-./}" stat
	(( NUMERIC < 0 )) && SEARCH_PATH=./

	[[ "${SEARCH_PATH[-1]}" == '/' ]] || return 1
	if ! [[ "${compstate[quoting]}" =~ 'single|double' ]]; then
		# eval should be safe to do in this branch
		SEARCH_PATH="$(eval printf '"%s\0"' "$SEARCH_PATH" 2>/dev/null)" stat=$?
		SEARCH_PATH="${SEARCH_PATH%$'\0'}"
		(( stat )) && return $stat
	fi
	[[ "${SEARCH_PATH}" == *$'\0'* ]] && return 1

	local FD_ARGS=(
		--print0
		--hidden
		--strip-cwd-prefix
		--base-directory="${SEARCH_PATH}"
	)

	local FZF_ARGS=(
		--read0
		--print0
		--multi
		--scheme=path
		--border-label-pos=3
		# Display on border if selection has non-printable character
		--bind='focus:transform-border-label(
			[[ {} =~ [^[:print:]] ]] && printf %q {}
		)'
	)

	print-special downline
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
