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

toggle-directory-history() {
# <Docs> () { nvim +/function.$1 $(antidote path jimhester/$1)/$1.zsh } per-directory-history </Docs>
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

# Replacing widget functionality for Ctrl-v
# Fixes pasting text when Ctrl-v is active
quoted-insert() {
	zle read-command
	[[ $REPLY == 'bracketed-paste' ]] && zle -U $KEYS || LBUFFER+=$KEYS
}
zle -N quoted-insert

clear-screen() { clear }
zle -N clear-screen
