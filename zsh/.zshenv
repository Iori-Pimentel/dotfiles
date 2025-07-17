#!/bin/zsh

export ZDOTDIR="${HOME}/.local/dotfiles/zsh"
path+=(${HOME}/.local/bin ${HOME}/.cargo/bin)
fpath+=(${ZDOTDIR}/fpath)
manpath+=(${PREFIX}/share/man)
export XDG_CONFIG_HOME"=${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
# Fixes plenary.nvim and leetcode.nvim
# https://github.com/nvim-lua/plenary.nvim/issues/536
export XDG_RUNTIME_DIR="${PREFIX}/tmp"

export VISUAL=nvim
export EDITOR=nvim
export PAGER=less

export FZF_DEFAULT_COMMAND='fd --hidden'
FZF_ARGS=(
	--height=40%
	--reverse
	--ignore-case
	--info=inline-right
	--ellipsis=
	--separator=
	--border=top
	--exit-0
	# Prevents getting stuck when used inside a widget
	--bind=ctrl-z:ignore
	# Move cursor to the first entry whenever the query is changed
	--bind=change:first
) export FZF_DEFAULT_OPTS="${FZF_ARGS[@]}"

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
