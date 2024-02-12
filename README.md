If using [Termux](https://github.com/termux/termux-app) and not [Termux-Monet](https://github.com/KitsunedFox/termux-monet), run this command first:
```bash
pkg install --yes --option Dpkg::Options::="--force-confnew" termux-tools
pkg upgrade --yes --option Dpkg::Options::="--force-confnew"
```

To install, run the command:
```bash
bash <(curl -fsSL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```

For faster z navigation, run the command:
```zsh
zshz --add ~/.termux
zshz --add ~/.local/dotfiles
zshz --add ~/.local/dotfiles/nvim
zshz --add ~/.local/dotfiles/zsh
```
