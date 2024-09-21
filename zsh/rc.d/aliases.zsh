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

# git:status
alias gs='git status'
alias gss='gs --short'

# git:info
alias gic='git-config-info'

# git:(updates staging area)
alias gmv='git mv'
alias grm='git rm'

# git:log
alias gl='git log --oneline --graph --all'
alias glr='git reflog'

# git:rebase
alias gru='git rebase --interactive @{upstream}'
alias grr='git rebase --interactive --root'
alias gre='git rebase --edit-todo'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

# git:patch
alias gps='git add --patch'
alias gpu='git reset --patch'
alias gpd='git restore --patch'

# git:add
alias ga='git add'
alias gai='ga --intent-to-add'

# git:clean
alias gc='git clean --interactive -d'

# git:diff
alias gd='git diff'
alias gdu='gd @{upstream}'
alias gds='gd --staged'
alias gdus='gdu --staged'

# git:commit
alias gc='git commit'
alias gca='gc --amend'

alias p='cd ~-'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
