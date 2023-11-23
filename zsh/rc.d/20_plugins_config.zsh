# ==== z ====

ZSHZ_DATA="${XDG_CACHE_HOME}/zsh/z"
ZSHZ_UNCOMMON=1 # match to uncommon prefix 
ZSHZ_CASE=smart # ignore case when lowercase, match case with uppercase 


# ==== fzf-tab ====
# TODO: preview
#zstyle ':fzf-tab:complete:eza:*' 
#zstyle ':fzf-tab::complete:*:directories' fzf-preview 'eza -1 --color=always $realpath'

# Nvim completion on recently opened files

zstyle ':fzf-tab:*' switch-group ':' '"'
zstyle ':fzf-tab:*' continuous-trigger 'tab'
zstyle ':fzf-tab:*' prefix ''

## Completion tweaks 
zstyle ':completion:*:default'      list-colors         "${(s.:.)LS_COLORS}" 
zstyle ':completion:*'              list-dirs-first     true 
zstyle ':completion:*'              verbose             true 
zstyle ':completion:*:all-files'    matcher             'r:|=** l:|=** m:{a-z\-}={A-Z\_}' #TODO: Understand
# zstyle ':completion::complete:*'    use-cache           true 
# zstyle ':completion::complete:*'    cache-path          "${XDG_CACHE_HOME}/zsh/compcache" 
zstyle ':completion:*:descriptions' format              [%d]
zstyle ':completion:*:manuals.*'    insert-sections     true
zstyle ':completion:*:manuals'      separate-sections   true
# zstyle ':completion:*:man:*'      menu yes select
# zstyle ':fzf-tab:complete:man:*' show-group none

# environment variable preview
# fix nowrap
# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
#   fzf-preview 'echo ${(P)word}'

# ==== auto-suggestions ====

ZSH_AUTOSUGGEST_MANUAL_REBIND=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(accept-line bracketed-paste fzf-tab-complete edit-command-line edit-command)

bindkey -e
 
# ==== antidote ====

zstyle ':antidote:bundle' use-friendly-names 'yes'
source "${ZDOTDIR}/.antidote/antidote.zsh"
[[ -r "${ZDOTDIR}/antidote-plugins.txt" ]] && antidote load "${ZDOTDIR}/antidote-plugins.txt"
