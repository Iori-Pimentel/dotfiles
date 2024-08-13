# Manually patched ~/.cache/antidote/agkozak/zsh-z/_zshz
# so that completion uses shortened named directories.
# This is different from ZSHZ_TILDE that only shortens $HOME to ~
# Patch: completion_list=(${(fD)completions[@]})
ZSHZ_DATA="${XDG_CACHE_HOME}/zsh/z"
ZSHZ_NO_RESOLVE_SYMLINKS=1
ZSHZ_CMD=z-plugin

typeset -A ZSH_HIGHLIGHT_STYLES
# Fixes comment visibility in gruvbox theme
ZSH_HIGHLIGHT_STYLES[comment]='fg=magenta,bold'

# hides unwanted prefix
zstyle ':fzf-tab:*' prefix ''
# enables colors for fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'
# removes header display
zstyle ':fzf-tab:*' show-group none
# applies color even for a single group
zstyle ':fzf-tab:*' single-group color
# prevents getting stuck when pressing ctrl-z
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-z:ignore'
# causes fzf-tab to trigger immediately
# instead of adding common prefix first
zstyle ':completion:*' menu yes

zstyle ':completion:*'            list-dirs-first  true
zstyle ':completion:*:cd:*'       complete-options yes
zstyle ':completion:*:parameters' ignored-patterns '_*'
# search for new commands first
zstyle ":completion:*:commands" rehash true

# disables rebind on every precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
# default strategy: history
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
	accept-line
	bracketed-paste
	fzf-tab-complete
	edit-command-line
	quoted-insert
)

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	os_icon dir per_directory_history vcs status
	newline prompt_char
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_DIR_MAX_LENGTH=30
# allows shortening current directory
POWERLEVEL9K_SHORTEN_DIR_LENGTH=0

POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_OK_PIPE=true
POWERLEVEL9K_STATUS_ERROR=true
# Turns off status icons
typeset -m 'POWERLEVEL9K_STATUS_*_VISUAL_IDENTIFIER_EXPANSION'=

zstyle ':antidote:bundle' use-friendly-names 'yes'
source "${XDG_CACHE_HOME}/antidote/.antidote/antidote.zsh"
antidote load "${ZDOTDIR}/plugins"
