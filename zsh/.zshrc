#!/bin/zsh

if [[ -o login ]]; then
	androfetch
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload ${ZDOTDIR}/fpath/*

source ${ZDOTDIR}/rc.d/setopt.zsh
source ${ZDOTDIR}/rc.d/hooks.zsh
source ${ZDOTDIR}/rc.d/aliases.zsh
source ${ZDOTDIR}/rc.d/widgets.zsh
source ${ZDOTDIR}/rc.d/p10k.zsh
# After p10k.zsh: plugins.zsh [contains p10k configs]
source ${ZDOTDIR}/rc.d/plugins.zsh
# After plugins.zsh: keys.zsh [rebinds plugin keys]
source ${ZDOTDIR}/rc.d/keys.zsh
source ${ZDOTDIR}/rc.d/misc.zsh
