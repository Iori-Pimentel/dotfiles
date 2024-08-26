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

# git:log
alias gl='git log --oneline --graph origin'
alias glr='git reflog'

# git:patch
alias gps='git add --patch'
alias gpu='git reset --patch'
alias gpd='git restore --patch'

# git:untracked
alias gus='git add --intent-to-add .'
alias guc='git clean --interactive -d'

# git:diff
alias gd='git diff'
alias gds='gd --staged'

# git:commit
alias gc='git commit --verbose'
alias gca='gc --amend'

alias p='cd ~-'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
