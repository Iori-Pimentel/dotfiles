If using [Termux](https://github.com/termux/termux-app) and not [Termux-Monet](https://github.com/KitsunedFox/termux-monet), run this command first:
```bash
pkg upgrade --yes --option Dpkg::Options::="--force-confnew"
termux-change-repo
```

To install, run the command:
```bash
source <(curl -fsSL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```
