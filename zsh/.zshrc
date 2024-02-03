#!/bin/zsh

if [[ -o login ]]; then
	androfetch
	tldr --quiet $(tldr --quiet --list | shuf -n1)
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for conffile in "${ZDOTDIR}"/rc.d/*.zsh; do
	source "${conffile}"
done
unset conffile
