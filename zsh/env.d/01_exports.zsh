# Prefered editor and pager
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less

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

# XDG basedir spec compliance
export XDG_CONFIG_HOME"=${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# best effort to make tools compliant to XDG basedir spec
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
