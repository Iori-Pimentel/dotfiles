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
https://github.com/localsend/localsend
https://github.com/Julow/Unexpected-Keyboard
https://github.com/termux/termux-api
https://github.com/termux/termux-app
https://gitlab.com/ironfox-oss/ironfox
https://gitlab.com/AuroraOSS/AuroraStore
https://mixplorer.com/beta
https://github.com/RikkaApps/Shizuku
https://github.com/samolego/Canta
```

Unexpected Keyboard XML
```xml
<?xml version="1.0" encoding="utf-8"?>
<keyboard name="Termux Layout" bottom_row="False" locale_extra_keys="False">
  <modmap>
    <shift a="capslock" b=""/>
    <fn a="capslock" b=""/>
    <ctrl a="capslock" b=""/>
  </modmap>
  <row>
    <key c="q" nw="0" se="@"/>
    <key c="w" nw="1" sw="2" se="3"/>
    <key c="e" nw="4" sw="5" se="6"/>
    <key c="r" nw="7" sw="8" se="9"/>
    <key c="t"/>
    <key c="y"/>
    <key c="u"/>
    <key c="i" sw="-" ne="|" se="~"/>
    <key c="o" sw="+" ne="&amp;" se="\"/>
    <key c="p"/>
  </row>
  <row>
    <key c="a" shift="0.5" se="esc" nw="tab"/>
    <key c="s" nw="{" se="(" sw="`"/>
    <key c="d" nw="}" se=")" sw="&quot;"/>
    <key c="f"/>
    <key c="g"/>
    <key c="h"/>
    <key c="j" sw="/" se=";" ne="*"/>
    <key c="k" sw="?" se="," ne="#"/>
    <key c="l"/>
  </row>
  <row>
    <key c="shift" width="1.5" nw="capslock"/>
    <key c="z" se="[" nw="&lt;" sw="%"/>
    <key c="x" se="]" nw="&gt;" sw="'"/>
    <key c="c"/>
    <key c="v"/>
    <key c="b"/>
    <key c="n" ne=":" sw="^" se="$"/>
    <key c="m" ne="=" sw="!" se="_"/>
    <key c="backspace" width="1.5" ne="delete"/>
  </row>
  <row height="0.95">
    <key c="ctrl" width="1.7"/>
    <key c="." width="1.1" sw="fn" se="alt"/>
    <key c="space" width="4.4"/>
    <key n="up" e="right" w="left" s="down" width="1.1"/>
    <key c="enter" width="1.7" se="config" ne="action" sw="switch_forward" nw="change_method"/>
  </row>
</keyboard>
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
https://github.com/ReVanced/GmsCore
https://github.com/ReVanced/revanced-manager
https://codeberg.org/comaps/comaps
https://github.com/thunderbird/thunderbird-android
https://github.com/jameskokoska/Cashew
https://github.com/revenge-mod/revenge-manager
https://github.com/drawpile/Drawpile
https://github.com/MuntashirAkon/AppManager
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
