alias eza='eza --all --no-user --icons=always --color=always --git --group-directories-first'
alias ll='eza --long'
alias lt='eza --tree --git-ignore --level 2'

alias q='exit'
alias qq='clear && session-cd save && exec zsh'
alias z='zshz /data/data/com.termux/files 2>&1'

alias n='nvim'

autoload shorten-path
autoload fzf-pkg

alias sp='shorten-path'
alias pk='fzf-pkg'

autoload git-config-info
alias gs='git status'
alias gc='git-config-info'
