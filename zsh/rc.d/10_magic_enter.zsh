zmodload zsh/terminfo 

# TODO: refactor
autoload redraw-prompt

accept-line () {
  if [[ -z $BUFFER ]] || ! grep --quiet '[^[:space:]]' <<< "$BUFFER"; then
    # redraw-prompt
    return
  fi

  zle .$WIDGET
  return

  # keep for reference
  echoti civis
  print -rn -- "${(pl:$((2 * LINES - 1))::\n:)}"
  zle -I
  zle -R
  print -rn -- ${${terminfo[cnorm]-}:/*$'\e[?25h'(|'\e'*)/$'\e[?25h'}

  echoti civis
  lines=$((LINES - 5))

  halfpage_down=""
  for i in {1..$lines}; do
    halfpage_down="$halfpage_down$terminfo[cud1]"
  done

  halfpage_up=""
  for i in {1..$lines}; do
    halfpage_up="$halfpage_up$terminfo[cuu1]"
  done

  if [[ -z $BUFFER ]]; then
    print ${halfpage_down}${halfpage_up}$terminfo[cuu1]
    zle reset-prompt
  else
    zle .$WIDGET
  fi

  echoti cnorm
}

zle -N accept-line
