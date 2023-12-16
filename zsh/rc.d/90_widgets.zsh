accept-line() {
	[[ "$BUFFER" =~ '[[:graph:]]' ]] && zle .$WIDGET
}
zle -N accept-line

edit-command() {
	setopt localoptions nomultibyte
	byteoffset=$(( $#LBUFFER + 1 ))

	() {
		# editor is assumed to be vim/nvim
		"$EDITOR" -c "normal! ${byteoffset}go" -- "$1"
		BUFFER="$(< $1)"
	} =(<<< "$BUFFER")

	CURSOR=${#BUFFER}
}
zle -N edit-command

# ──────────────────────────────────────────────────


autoload -z edit-command-line
zle -N edit-command-line

bracketed-paste() {
	local PASTED
	zle .$WIDGET PASTED

	read -r -d '' trimmed <<< "$PASTED"

	LBUFFER+="$trimmed"
	[[ "$trimmed" =~ $'\n' ]] && zle edit-command-line
}
zle -N bracketed-paste

# ──────────────────────────────────────────────────

# [Docs]
# () { local plugin='per-directory-history'
#   less -i "+/function $plugin" \
#   $(antidote path jimhester/$plugin)/$plugin.zsh }

toggle-directory-history() {
# Addressed issue with per-directory-history-toggle-history creating a new
# prompt at each call; resolved by copying the source code and removing zle -I.
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

zle -N toggle-directory-history

# ──────────────────────────────────────────────────

quote-insert() {
	# fix autopair
	# fix Ctrl-Alt-V
	# find ESC widget
}
