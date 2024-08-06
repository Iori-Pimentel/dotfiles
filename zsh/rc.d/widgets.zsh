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
		--print-query
		--expect=tab
		# Exclude first field in search
		# This allows ^command searches
		--nth '2..'
		# To hide it instead, use --with-nth
		--border-label-pos=3
		--border-label="[tab]: query 'arg => *arg*"
	)

	before-fzf
	local FZF_QUERY FZF_KEY HISTORY_NUM _
	fc "${FC_ARGS[@]}" |
	awk "${AWK_ARG}" |
	sed "${SED_ARGS[@]}" |
	fzf "${FZF_ARGS[@]}" |
	{ read FZF_QUERY && read FZF_KEY && read HISTORY_NUM _ }
	after-fzf

	zle reset-prompt

	# Lines imported by SHARE_HISTORY option
	# end with a * character which we ignore
	HISTORY_NUM=${HISTORY_NUM%%[*]}

	(( $HISTORY_NUM )) || return 1

	if [[ $FZF_KEY == tab ]]; then
		local ARG_TO_MATCH ARG
		# Last word in query
		ARG_TO_MATCH=( "${=FZF_QUERY}" )
		ARG_TO_MATCH="${ARG_TO_MATCH[-1]}"

		# Assumes fzf --extended (which is default)
		# Continue only if using ['] exact mode
		[[ "${ARG_TO_MATCH}" == "'"* ]] || return
		ARG_TO_MATCH="${ARG_TO_MATCH##[']}"

		# split line into shell arguments
		ARG=( "${(z)history[$HISTORY_NUM]}" )
		# Search arguments that contains ARG_TO_MATCH
		ARG=( "${(M)ARG[@]:#(#i)*${ARG_TO_MATCH}*}" )
		# Select last argument
		ARG="${ARG[-1]}"

		LBUFFER+="${ARG}"
	else
		# Updating HISTNO updates the BUFFER using a
		# history list that includes edits
		# which doesn't match with fc so we use
		# ${history[$HISTORY_NUM]} which matches
		HISTNO="$HISTORY_NUM"
		BUFFER="${history[$HISTORY_NUM]}"
		CURSOR="$#BUFFER"
	fi
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

	# Dont know if setopt is necessary.
	setopt LOCAL_OPTIONS LOCAL_TRAPS
	# Special case for completion widgets:
	# Cannot call zle directly. Must use TRAPEXIT.
	TRAPEXIT() { zle reset-prompt }

	[[ -z "${FILE_PATH}" ]] && return 1
	# FIXME: does not preserve LBUFFER contents
	compadd -P "${PREFIX}" -fW "${SEARCH_PATH}" -- "${FILE_PATH%/}"
}

# Fix for fzf clearing right side of current line
before-fzf() {
	echoti cud1 >/dev/tty
}
after-fzf() {
	echoti cuu1 >/dev/tty
}
