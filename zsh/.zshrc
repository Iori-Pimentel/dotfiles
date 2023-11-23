#!/bin/zsh
# Show motd only if different
if ! cmp -s "${HOME}/.hushlogin" "${PREFIX}/etc/motd"; then
    tee "${HOME}/.hushlogin" < "${PREFIX}/etc/motd"
    read -k1 "REPLY?Press Enter to continue: "
    echo
fi

autoload load-dir; load-dir

[[ $(uname -o) == "Android" ]] && androfetch
tldr --quiet $(tldr --quiet --list | shuf -n1)
  
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.local/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for conffile in "${ZDOTDIR}"/rc.d/*.zsh; do
    source "${conffile}" 
done 
unset conffile

# To customize prompt, run `p10k configure` or edit ~/.local/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.local/dotfiles/zsh/.p10k.zsh ]] || source ~/.local/dotfiles/zsh/.p10k.zsh
