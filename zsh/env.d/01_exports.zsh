# Prefered editor and pager
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS="--RAW-CONTROL-CHARS --jump-target .7 --ignore-case --hilite-unread --LONG-PROMPT --window=-4 --tabs=4"

# XDG basedir spec compliance
export XDG_CONFIG_HOME"=${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# best effort to make tools compliant to XDG basedir spec
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
