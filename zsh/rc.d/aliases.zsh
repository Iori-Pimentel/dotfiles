alias eza='eza --all --no-user --icons=always --color=always --git --group-directories-first'
alias ll='eza --long'
alias lt='eza --tree --git-ignore --level 2'

alias qq=' clear && session-cd save && exec zsh'
alias q=' exit'

# TODO: completion ( z; fzf-files )
alias z='z-plugin /data/data/com.termux/files'
alias n='nvim'

alias pk='fzf-pkg'
alias pkf='pkg files'
alias pks='dpkg --search'

alias gs='git status'
alias gc='git-config-info'

alias p='cd ~-'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
