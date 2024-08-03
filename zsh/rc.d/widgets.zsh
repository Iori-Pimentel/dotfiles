zle -N edit-command-line
autoload edit-command-line

zle -N accept-line
accept-line() {
	[[ "$BUFFER" =~ '[^[:space:]]' ]] && zle .accept-line
}

# Warning if pasting Ctrl-c:
# Ctrl-c sends an interrupt signal instead of a literal ^C,
# causing bracketed-paste to not trigger,
# which breaks literal pasting functionality
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

zle -N fzf-argument
fzf-argument() {
	zmodload zsh/parameter 2>/dev/null # For history parameter

	# NOTE: historywords parameter is not used because it does not
	# split properly if HIST_LEX_WORDS option is unset
	# (u) unique elements only
	# (z) split as shell arguments
	LBUFFER+="$(printf '%s\0' "${(uz)history[@]}" | fzf --read0)"

	zle reset-prompt
}

zle -N fzf-history
fzf-history() {
	local FC_ARGS=(
		-l # list
		-r # reverse
		1 # history starting from 1
	)

	# Filter duplicate commands
	local AWK_ARG='{ line=$0; $1=""; if (!seen[$0]++) print line }'

	local EXPRESSION_ARGS=(
		'^[0-9]*'
		# set dim and italic
		$'\e[2;3m'
		# reset
		$'\e[m'
	)

	local SED_ARGS=(
		# Convert first column from right to left align
		--expression='s/^[[:space:]]*//'
		# Set styles for first column
		--expression="$(
			printf 's/%s/%s&%s/' "${EXPRESSION_ARGS[@]}"
		)"
	)

	local FZF_ARGS=(
		--ansi
		--scheme=history
		--query="^${LBUFFER//[^[:print:]]/ }"
		# Exclude first field in search
		# This allows ^command searches
		--nth '2..'
		# To hide it instead, use --with-nth
	)

	local HISTORY_NUM _

	fc "${FC_ARGS[@]}" |
	awk "${AWK_ARG}" |
	sed "${SED_ARGS[@]}" |
	fzf "${FZF_ARGS[@]}" | read HISTORY_NUM _

	zle reset-prompt

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

	local FILE_PATH
	FILE_PATH="$(fd "${FD_ARGS[@]}" 2>/dev/null | fzf "${FZF_ARGS[@]}")"
	FILE_PATH="${FILE_PATH%$'\0'}"

	# Dont know if setopt is necessary.
	setopt LOCAL_OPTIONS LOCAL_TRAPS
	# Special case for completion widgets:
	# Cannot call zle directly. Must use TRAPEXIT.
	TRAPEXIT() { zle reset-prompt }

	[[ -z "${FILE_PATH}" ]] && return 1
	# FIXME: does not preserve LBUFFER contents
	compadd -P "${PREFIX}" -fW "${SEARCH_PATH}" -- "${FILE_PATH%/}"
}
