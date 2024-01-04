setopt APPEND_HISTORY     # history appends to existing file
setopt SHARE_HISTORY      # import new commands from the history file also in other zsh-session
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt EXTENDED_HISTORY   # save each commands beginning timestamp and the duration to the history file
setopt HIST_REDUCE_BLANKS # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_SPACE  # don’t store lines starting with space

setopt EXTENDED_GLOB # treat special characters as part of patterns
setopt GLOB_DOTS     # match hidden files

setopt NOTIFY         # report status of background jobs immediately
setopt AUTO_RESUME    # attempt to resume existing job before creating a new process
setopt LONG_LIST_JOBS # list jobs in the long format by default

setopt no_BEEP         # do not beep on errors
setopt no_NOMATCH      # try to avoid the 'zsh: no matches found...'
setopt no_FLOW_CONTROL # disable ^S and ^Q
setopt no_SHORT_LOOPS  # disable short loop forms, can be confusing

setopt CORRECT_ALL          # try to correct the spelling of all arguments in a line
setopt MULTIOS              # allows multiple input and output redirections
setopt CLOBBER              # allow > redirection to truncate existing files
setopt BRACE_CCL            # allow brace character class list expansion
setopt INTERACTIVE_COMMENTS # allow use of comments in interactive code
setopt AUTO_PARAM_SLASH     # complete folders with / at end
setopt LIST_TYPES           # mark type of completion suggestions
setopt HASH_LIST_ALL        # whenever a command completion is attempted, make sure the entire command path is hashed first
setopt COMPLETE_IN_WORD     # allow completion from within a word/phrase
setopt ALWAYS_TO_END        # move cursor to the end of a completed word

# a bit fancy than default
PROMPT_EOL_MARK='%K{red} %k'
