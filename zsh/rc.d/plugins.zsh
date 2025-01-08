ZSHZ_DATA="${XDG_CACHE_HOME}/zsh/z"
ZSHZ_NO_RESOLVE_SYMLINKS=1
ZSHZ_CMD=z-plugin

typeset -A ZSH_HIGHLIGHT_STYLES
# Fix highlight visibility in gruvbox theme
ZSH_HIGHLIGHT_STYLES[comment]='fg=white,bold'
ZSH_HIGHLIGHT_MAXLENGTH=100

# hides unwanted prefix
zstyle ':fzf-tab:*' prefix ''
# enables colors for fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'
# removes header display
zstyle ':fzf-tab:*' show-group none
# applies color even for a single group
zstyle ':fzf-tab:*' single-group color
# overrides fzf-tab --cycle option
zstyle ':fzf-tab:*' fzf-flags '--no-cycle'
# disable using / as continuous-trigger
zstyle ':fzf-tab:*' continuous-trigger ''
# prevents getting stuck when pressing ctrl-z,
# also replaces unwanted default bindings
zstyle ':fzf-tab:*' fzf-bindings-default 'ctrl-z:ignore'
zstyle ':fzf-tab:*' fzf-bindings-default 'right:accept'
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# causes fzf-tab to trigger immediately
# instead of adding common prefix first
zstyle ':completion:*' menu yes

zstyle ':completion:*'            list-dirs-first  true
zstyle ':completion:*:cd:*'       complete-options yes
zstyle ':completion:*:parameters' ignored-patterns '_*'
# searches for new commands during completion
zstyle ":completion:*:commands" rehash true

# disables rebind on every precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
# default strategy: history
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Ignore history longer than 100 chars or has newline
ZSH_AUTOSUGGEST_HISTORY_IGNORE=$'?(#c100,)|*\n*'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
	accept-line
	bracketed-paste
	fzf-tab-complete
	edit-command-line
	quoted-insert
)

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	os_icon dir vcs status
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
