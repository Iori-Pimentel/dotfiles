# ─────────────────────────────────────────────────
_space-pair() {
  _ap-can-delete-p && [[ $LBUFFER =~ ' $' ]]
}

_remove-opening-pairs() {
  PAIRS="${(@k)AUTOPAIR_PAIRS}"
  tr -d "$PAIRS" <<< "$WORDCHARS"
}

_at-boundary() {
  [[ -z "$LBUFFER" ]] && return 0

  [[ "$LBUFFER" =~ "" ]]

  
}

_opening-pair-at-last() {
  PAIRS="${(@k)AUTOPAIR_PAIRS}"
  LAST_CHAR="$LBUFFER:0:1"
  [[ -z "$(tr -d $PAIRS <<< $LAST_CHAR)" ]]
}

_last-char-is-word() {
  [[ "$1" =~ "[[:alnum:]]$" ]] && return 0
  [[ "$1" =~ " $" ]] && return 1

  # TODO: make not loop
  for char in $(echo "$WORDCHARS" | sed "s:\S:& :g"); do
    [[ "$1" =~ '\'$char'$' ]] && return 0
  done

  return 1
}

_rbuffer-no-pair() {
  [[ -z "$RBUFFER" ]] && return 0
  [[ "$RBUFFER" =~ ' $' ]] && return 1
  PAIRS="${(@v)AUTOPAIR_PAIRS}"

  for char in $(echo "$PAIRS"); do
    [[ "$RBUFFER" =~ '\'$char'$' ]] && return 1
  done

  return 0
}

# TODO: fix lag
backward-kill-word() {
  _space-pair && zle autopair-delete && return
  LBUFFER="${LBUFFER%%[[:space:]]#}"
  
  while ! [[ "$LBUFFER" =~ ' $' ]] && ! [[ -z "$LBUFFER" ]]; do
    zle autopair-delete
  done
}

zle -N backward-kill-word

# ──────────────────────────────────────────────────


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

  [[ $(wc -l <<< $trimmed) != 1 ]] && zle edit-command-line
}
zle -N bracketed-paste

# ──────────────────────────────────────────────────

# [Docs]
# () { local plugin='per-directory-history'
#   less -i "+/function $plugin" \
#   $(antidote path jimhester/$plugin)/$plugin.zsh }

toggle-directory-history() {
# Addressed issue with per-directory-history-toggle-history by creating a new
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
