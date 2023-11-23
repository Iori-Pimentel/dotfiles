# Prefered editor and pager 
export VISUAL=nvim 
export EDITOR=nvim 
export PAGER=less
# TODO add more
export LESS="--RAW-CONTROL-CHARS --jump-target .7 --ignore-case --hilite-unread --LONG-PROMPT --window=-4 --tabs=4"

# XDG basedir spec compliance 
[[ -v XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME"=${HOME}/.config"
[[ -v XDG_CACHE_HOME  ]] || export XDG_CACHE_HOME="${HOME}/.cache"
[[ -v XDG_DATA_HOME   ]] || export XDG_DATA_HOME="${HOME}/.local/share"
[[ -v XDG_STATE_HOME  ]] || export XDG_STATE_HOME="${HOME}/.local/state"
[[ -v XDG_RUNTIME_DIR ]] || export XDG_RUNTIME_DIR="${TMPDIR:-${PREFIX}/tmp}/runtime-${USER:-${USERNAME}}" # FIXME: change termux specific vars

export CARGO_HOME="$XDG_DATA_HOME"/cargo
# best effort to make tools compliant to XDG basedir spec
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config" 
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
