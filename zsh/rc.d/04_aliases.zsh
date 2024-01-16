alias eza='eza --all --no-user --icons=always --color=always --git --group-directories-first'
alias ll='eza --long'
alias lt='eza --tree --git-ignore --level 2'

alias q='exit'
alias qq='clear && session-cd save && exec zsh'

alias n='nvim'
alias na='NVIM_APPNAME=a-nvim nvim'

autoload shorten-path
autoload fzf-pkg

alias sp='shorten-path'
alias pk='fzf-pkg'

autoload git-config-info
alias gs='git status'
alias gc='git-config-info'

export LESS_TERMCAP_md=$(echoti bold; echoti setaf 1)
export LESS_TERMCAP_mb=$(echoti blink)
export LESS_TERMCAP_me=$(echoti sgr0)
export LESS_TERMCAP_so=$(echoti smso)
export LESS_TERMCAP_se=$(echoti rmso)
export LESS_TERMCAP_us=$(echoti smul; echoti setaf 2)
export LESS_TERMCAP_ue=$(echoti sgr0)
