#!/bin/zsh

if [[ -o login ]]; then
	androfetch
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload ${ZDOTDIR}/fpath/*

# After {hooks,p10k}.zsh: plugins.zsh
source ${ZDOTDIR}/rc.d/hooks.zsh
source ${ZDOTDIR}/rc.d/p10k.zsh
source ${ZDOTDIR}/rc.d/plugins.zsh
source ${ZDOTDIR}/rc.d/directory-history.zsh
# After plugins.zsh: {aliases,keys}.zsh
source ${ZDOTDIR}/rc.d/aliases.zsh
source ${ZDOTDIR}/rc.d/keys.zsh
source ${ZDOTDIR}/rc.d/widgets.zsh
source ${ZDOTDIR}/rc.d/misc.zsh
