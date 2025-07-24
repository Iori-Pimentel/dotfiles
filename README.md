If using [Termux](https://github.com/termux/termux-app) and not [Termux-Monet](https://github.com/KitsunedFox/termux-monet), run this command first:
```bash
pkg upgrade --yes --option Dpkg::Options::="--force-confnew"
termux-change-repo
```

To install, run the command:
```bash
bash <(curl -fsSL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```

# Android Setup

Install [Obtainium](https://github.com/ImranR98/Obtainium) then import:
[Creating a GitHub Personal Access Token](https://github.com/settings/personal-access-tokens)

Bare Minimum
```
https://github.com/Kunzisoft/KeePassDX
https://github.com/Julow/Unexpected-Keyboard
https://github.com/termux/termux-api
https://github.com/termux/termux-app
https://gitlab.com/ironfox-oss/ironfox
https://gitlab.com/AuroraOSS/AuroraStore
https://github.com/ReVanced/GmsCore
https://github.com/ReVanced/revanced-manager
https://mixplorer.com/beta
```

Configuration
```
- https://mixplorer.com/beta/
    - versionExtractionRegEx='[0-9.]+.Beta.[0-9B]+'
    - apkFilterRegEx='arm64'
- https://github.com/Kunzisoft/KeePassDX
    - apkFilterRegEx='libre'
- https://github.com/ReVanced/GmsCore,
    - apkFilterRegEx='hw|huawei'
    - invertAPKFilter=True
```

Aurora Store
```
https://play.google.com/store/apps/details?id=com.github.android
https://play.google.com/store/apps/details?id=com.samsung.android.sidegesturepad
https://play.google.com/store/apps/details?id=com.urbandroid.kinestop
```

Archive
```
https://codeberg.org/comaps/comaps
https://github.com/thunderbird/thunderbird-android
https://github.com/localsend/localsend
https://github.com/jameskokoska/Cashew
https://github.com/revenge-mod/revenge-manager
https://github.com/drawpile/Drawpile
https://github.com/MuntashirAkon/AppManager
https://github.com/RikkaApps/Shizuku
```

Not sure
```
https://github.com/TrianguloY/URLCheck
https://github.com/LinkSheet/nightly
https://github.com/ReadYouApp/ReadYou
https://github.com/ycngmn/Nobook
https://github.com/soupslurpr/AppVerifier
https://github.com/newhinton/Round-Sync
https://github.com/logseq/logseq
https://f-droid.org/packages/net.typeblog.shelter
```
