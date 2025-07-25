# Configuring my Samsung Tab S7 FE

## Installation/Setup Wizard
- Uncheck all optional checkboxes
- Skip connecting to wifi
- Skip all account login/signin

## Bare Minimum Install
- Disable Google Play Store
- Connect to wifi
- Install Obtainium in Chrome
- Import `Bare Minimum` in Obtainium:
```
https://github.com/RikkaApps/Shizuku
https://f-droid.org/en/packages/io.github.samolego.canta
https://f-droid.org/packages/juloo.keyboard2
https://f-droid.org/en/packages/com.termux.api
https://f-droid.org/en/packages/com.termux
https://f-droid.org/packages/com.aurora.store
https://gitlab.com/ironfox-oss/ironfox
https://mixplorer.com/beta
https://f-droid.org/packages/org.localsend.localsend_app
https://f-droid.org/en/packages/com.kunzisoft.keepass.libre
```
- Configure Mixplorer in Obtainium
```
versionExtractionRegEx: [0-9.]+.Beta.[0-9B]+
apkFilterRegEx: arm64
```
- Enable Shizuku and clean up using [Canta](android/canta.json)

## Configuration
- Run in Termux:
```bash
pkg upgrade --yes --option Dpkg::Options::="--force-confnew"
termux-change-repo
bash <(curl -fsSL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```
- Configure Home Screen Settings
```
Home Screen Layout: Home Screen Only
App Icon Badge: Off
Search From Home: Off
```
- Configure Display Settings
```
Screen Timeout: 30 minutes
Edge Panels: Off
Taskbar: Off
Navigation Type: Swipe From Bottom
Block Gestures with S-Pen: On
```
- Configure Lock Screen Settings
```
Touch and Hold to Edit: Off
Widgets: None
```
- Configure Recent Apps
```
Show Reccommended Apps: Off
```
- Configure Notification Settings
```
Lock Screen Notification: Off
Show Notification Icons: All
```
- Configure [Unexpected Keyboard](android/unexpected-keyboard/config.xml)
```
Landscape Height: 30%
Horizontal Margin: 200dp
Automatic Capitalization: Off
Remove keys: Compose, Voice Typing, Clipboard Manager
```
- Configure App Info
```
Unrestricted Battery: Termux, Termux API
Appear on Top: Termux, Termux API
Set as Default: Aurora Store
```
- Install and Configure [One Hand Operation+](https://play.google.com/store/apps/details?id=com.samsung.android.sidegesturepad)
```
Right Top: Previous App, Task Switcher
Right Bottom: Quick Tools, Quick Launcher
S Pen Gestures: Off
Long Swipe Duration: 0ms
```

## Importing Data
- Acquire passwords in LocalSend
- Login to accounts
