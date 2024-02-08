#!/bin/zsh

export ZDOTDIR="${HOME}/.local/dotfiles/zsh"
fpath+=(${ZDOTDIR}/fpath)
manpath+=(${PREFIX}/share/man)
export XDG_CONFIG_HOME"=${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export VISUAL=nvim
export EDITOR=nvim
export PAGER=less

export FZF_DEFAULT_COMMAND='fd --hidden'
# https://github.com/sharkdp/fd/issues/1461
# Temporary fix for fd not respecting .gitignore in a subdirectory
export FZF_DEFAULT_COMMAND='rg --hidden --files'
export FZF_DEFAULT_OPTS='--height 40% --reverse'

# Sets color for manpages in less
export LESS_TERMCAP_md=$(echoti bold; echoti setaf 1)
export LESS_TERMCAP_mb=$(echoti blink)
export LESS_TERMCAP_me=$(echoti sgr0)
export LESS_TERMCAP_so=$(echoti smso)
export LESS_TERMCAP_se=$(echoti rmso)
export LESS_TERMCAP_us=$(echoti smul; echoti setaf 2)
export LESS_TERMCAP_ue=$(echoti sgr0)
LESS_ARGS=(
	--hilite-unread  # highlight unread lines when navigating
	--status-line    # navigation highlight covers entire line
	--window=-4      # position for navigation
	--jump-target=.7 # position for searches
	--LONG-PROMPT    # adds more info to statusbar
	--RAW-CONTROL-CHARS # git requirement for less as pager
	--ignore-case
	--tabs=4
) export LESS="${LESS_ARGS[@]}"
