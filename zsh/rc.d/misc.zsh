setopt EXTENDED_GLOB # treat [#~^] as patterns for filename generation
setopt GLOB_DOTS     # match hidden files during filename generation

setopt INTERACTIVE_COMMENTS # allow comments in interactive mode

setopt no_BEEP         # do not beep on errors
setopt no_FLOW_CONTROL # disable ^S and ^Q

setopt INC_APPEND_HISTORY # appends to the history file immediately, not when the shell exits
setopt EXTENDED_HISTORY   # add timestamps in commands
setopt HIST_REDUCE_BLANKS # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_SPACE  # don’t store lines starting with space

mkdir -p "${XDG_DATA_HOME}/zsh"
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# a bit fancy than default
PROMPT_EOL_MARK='%K{red} %k'

# named directories
hash -d PREFIX="$PREFIX"

# enable completion
autoload compinit
compinit -d "$XDG_CACHE_HOME/zsh/compdump"

# Removes duplicate entries
typeset -U path cdpath fpath manpath
