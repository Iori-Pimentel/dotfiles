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
	# Fixes the problem of fc having output even with empty history
	(( $#history > 0 )) || return 1

	local FC_ARGS=(
		-l # list
		-r # reverse
		1 # history starting from 1
	)

	# Filter duplicate commands
	local AWK_ARG='{ line=$0; $1=""; if (!seen[$0]++) print line }'

	local SET_COLOR
	local RESET_COLOR=$'\e[m'
	# zsh/rc.d/directory-history.zsh colors
	if [[ $CURRENT_HISTFILE == $GLOBAL_HISTFILE ]]
	then SET_COLOR=$'\e[33m' # Yellow
	elif [[ $OTHER_HISTFILE == $GLOBAL_HISTFILE ]]
	then SET_COLOR=$'\e[35m' # Magenta
	else SET_COLOR=$'\e[2;3m' # dim and italic
	fi

	local SED_ARGS=(
		# Convert first column from right to left align
		--expression='s/^[[:space:]]*//'
		# Set styles for first column
		--expression='s/^[0-9]*/'${SET_COLOR}'&'${RESET_COLOR}'/'
	)

	local FZF_ARGS=(
		--ansi
		--scheme=history
		--bind=ctrl-r:'become(printf toggle)'
		# Exclude first field in search
		# This allows ^command searches
		# Use --with-nth to hide field
		--nth '2..'
	)

	before-fzf
	local FZF_QUERY FZF_KEY HISTORY_NUM _
	fc "${FC_ARGS[@]}" |
	awk "${AWK_ARG}" |
	sed "${SED_ARGS[@]}" |
	fzf "${FZF_ARGS[@]}" | read HISTORY_NUM _
	after-fzf

	zle reset-prompt

	# if fzf returned "toggle" instead of a number
	if [[ $HISTORY_NUM == toggle ]]; then
		zle toggle-history-list && zle -U $KEYS && return
	fi

	# Lines imported by SHARE_HISTORY option
	# end with a * character which we ignore
	HISTORY_NUM=${HISTORY_NUM%%[*]}

	(( $HISTORY_NUM )) || return 1

	# Updating HISTNO updates the BUFFER using a
	# history list that includes edits
	# which doesn't match with fc so we use
	# ${history[$HISTORY_NUM]} which matches
	HISTNO="$HISTORY_NUM"
	BUFFER="${history[$HISTORY_NUM]}"
	CURSOR="$#BUFFER"
}

zle -C fzf-files complete-word fzf-files
fzf-files() {
	local SEARCH_PATH
	if [[ "${compstate[quoting]}" =~ 'single|double' ]]; then
		SEARCH_PATH="${PREFIX}"
	else
		# eval should be safe to do in this branch
		SEARCH_PATH="$(eval printf '"%s\0"' "$PREFIX" 2>/dev/null)" || return 1
		SEARCH_PATH="${SEARCH_PATH%$'\0'}"
	fi

	[[ -z "${PREFIX}" ]] && SEARCH_PATH='./'

	[[ "${SEARCH_PATH}" == *$'\0'* ]] && return 1
	[[ "${SEARCH_PATH[-1]}" == '/' ]] || return 1

	local FD_ARGS=(
		--print0
		--hidden
		--strip-cwd-prefix
		--base-directory="${SEARCH_PATH}"
	)

	local FZF_ARGS=(
		--read0
		--print0
		--scheme=path
		--border-label-pos=3
		# Display on border if selection has non-printable character
		--bind='focus:transform-border-label(
			[[ {} =~ [^[:print:]] ]] && printf %q {}
		)'
	)

	before-fzf
	local FILE_PATH
	FILE_PATH="$(fd "${FD_ARGS[@]}" 2>/dev/null | fzf "${FZF_ARGS[@]}")"
	FILE_PATH="${FILE_PATH%$'\0'}"
	after-fzf

	setopt LOCAL_OPTIONS LOCAL_TRAPS
	# Special case for completion widgets:
	# Cannot call zle directly. Must use TRAPEXIT.
	TRAPEXIT() { zle reset-prompt }

	[[ -z "${FILE_PATH}" ]] && return 1
	compadd -P "${PREFIX}" -fW "${SEARCH_PATH}" -- "${FILE_PATH%/}"
}

# Fix for fzf clearing right side of current line
before-fzf() {
	echoti cud1 >/dev/tty
}
after-fzf() {
	echoti cuu1 >/dev/tty
}
