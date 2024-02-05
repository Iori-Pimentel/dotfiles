HISTORY_BASE="${XDG_DATA_HOME}/zsh/directory-history"

ZSHZ_DATA="${XDG_CACHE_HOME}/zsh/z"
ZSHZ_NO_RESOLVE_SYMLINKS=1

# hides unwanted prefix
zstyle ':fzf-tab:*' prefix ''
# enables colors for fzf-tab
zstyle ':completion:*:descriptions' format [%d]
# removes header display
zstyle ':fzf-tab:*' show-group none
# applies color even for a single group
zstyle ':fzf-tab:*' single-group color

zstyle ':completion:*'            list-dirs-first  true
zstyle ':completion:*:cd:*'       complete-options yes
zstyle ':completion:*:parameters' ignored-patterns '_*'
autoload compinit && compinit

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
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-word
	forward-word-path
)

zstyle ':antidote:bundle' use-friendly-names 'yes'
source "${ZDOTDIR}/.antidote/antidote.zsh"
antidote load "${ZDOTDIR}/antidote-plugins.txt"
