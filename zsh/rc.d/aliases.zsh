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
alias gconf='git-config-info'
alias gl='git log --oneline'

alias gps='git add --patch'
alias gpu='git reset --patch'
alias gpd='git restore --patch'
alias gpc='git commit --patch'

alias gd='git diff'
alias gds='git diff --staged'

alias gns='git add --intent-to-add .'
alias gnd='git clean --interactive'

alias gc='git commit'
alias gca='git commit --amend'
alias gcs='git show'
alias gcr='git revert --no-commit'

alias gri='git rebase --interactive'
alias grc='git rebase --continue'
alias gre='git rebase --edit-todo'

alias gws='git stash'
alias gwp='git stash pop'

alias p='cd ~-'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
