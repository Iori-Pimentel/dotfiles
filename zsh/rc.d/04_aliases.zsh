# ================= Aliases =================

# alias l="eza --group-directories-first --classify --icons --color=auto"
alias ll="eza -la --group-directories-first --no-user --git --icons --color=always"
alias lt="eza --tree --icons --color=auto"
alias lta="eza --tree --icons --no-user --no-time --no-filesize -la --color=auto"
alias bat="bat --theme OneHalfDark"
alias f="rga-fzf"
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget/wget-hsts"

alias qq='save-dir && clear && exec zsh -l'

autoload shorten-path
autoload fzf-pkg

alias sp='shorten-path'
alias pk="fzf-pkg"

# History suppression
alias c=" clear; echo"
alias pwd=" pwd"
alias q=" exit"
alias p=' cd ~-'
alias o=" cd .."
alias oo=" cd ../.."
alias ooo=" cd ../../.."

alias n="nvim"
export LESS_TERMCAP_md=$(echoti bold; echoti setaf 1) 
export LESS_TERMCAP_mb=$(echoti blink) 
export LESS_TERMCAP_me=$(echoti sgr0) 
export LESS_TERMCAP_so=$(echoti smso) 
export LESS_TERMCAP_se=$(echoti rmso) 
export LESS_TERMCAP_us=$(echoti smul; echoti setaf 2) 
export LESS_TERMCAP_ue=$(echoti sgr0) 
