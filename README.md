If preexisting dotfiles, run this command first:
```bash
mv ~/.local/dotfiles "${PREFIX}/tmp"
```

To install, run the command:
```bash
bash <(curl -fssL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```

For faster z navigation, run the command:
```zsh
zshz --add ~/.termux
zshz --add ~/.local/dotfiles
zshz --add ~/.local/dotfiles/nvim
zshz --add ~/.local/dotfiles/zsh
```
