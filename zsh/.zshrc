#!/bin/zsh

if [[ -o login ]]; then
	androfetch
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload ${ZDOTDIR}/fpath/*
print-special barcursor

# Files with no function definition
source ${ZDOTDIR}/rc.d/misc.zsh
source ${ZDOTDIR}/rc.d/aliases.zsh
source ${ZDOTDIR}/rc.d/keys.zsh
# Files with function definition
source ${ZDOTDIR}/rc.d/widgets.zsh
source ${ZDOTDIR}/rc.d/directory-history.zsh
source ${ZDOTDIR}/rc.d/hooks.zsh
# Files with plugins
source ${ZDOTDIR}/rc.d/p10k.zsh
source ${ZDOTDIR}/rc.d/plugins.zsh
