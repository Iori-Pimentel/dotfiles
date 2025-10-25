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
```text
https://github.com/RikkaApps/Shizuku
https://f-droid.org/en/packages/io.github.samolego.canta
https://f-droid.org/packages/juloo.keyboard2
https://f-droid.org/en/packages/com.termux.api
https://f-droid.org/en/packages/com.termux
https://gitlab.com/AuroraOSS/AuroraStore
https://gitlab.com/ironfox-oss/ironfox
https://mixplorer.com/beta
https://f-droid.org/packages/org.localsend.localsend_app
https://f-droid.org/en/packages/com.kunzisoft.keepass.libre
```
- Configure Mixplorer in Obtainium
    - versionExtractionRegEx: `[0-9.]+.Beta.[0-9B]+`
    - apkFilterRegEx: `arm64`
- Click "Tap to finish setting up" notification
- Enable Shizuku and clean up using [Canta](android/canta.json)

## Termux Configuration
- Run in Termux:
```bash
bash <(curl -fsSL https://github.com/iori-pimentel/dotfiles/raw/main/deploy.sh)
```
<details><summary> Home Screen Settings </summary>

| Setting             | Value              |
|---------------------|--------------------|
| Home Screen Layout  | Home Screen Only   |
| App Icon Badge      | Off                |
| Search From Home    | Off                |
</details>

<details><summary> Display Settings </summary>

| Setting                     | Value             |
|-----------------------------|-------------------|
| Screen Timeout              | 30 minutes        |
| Edge Panels                 | Off               |
| Taskbar                     | Off               |
| Navigation Type             | Swipe From Bottom |
| Block Gestures with S-Pen   | On                |
</details>

<details><summary> Lock Screen Settings </summary>

| Setting                | Value |
|------------------------|-------|
| Touch and Hold to Edit | Off   |
| Widgets                | None  |
</details>

<details><summary> Recent Apps Settings </summary>

| Setting               | Value |
|-----------------------|-------|
| Show Recommended Apps | Off   |
</details>

<details><summary> Notification Settings </summary>

| Setting                  | Value |
|--------------------------|-------|
| Lock Screen Notification | Off   |
| Show Notification Icons  | All   |
</details>

<details><summary> Side Button Settings </summary>

| Setting         | Action          |
|-----------------|-----------------|
| Double Press    | Off             |
| Press and Hold  | Power Off Menu  |
</details>

<details><summary> Unexpected Keyboard Config </summary>

| Option                   | Value                         |
|--------------------------|-------------------------------|
| Landscape Height         | 30%                           |
| Horizontal Margin        | 200dp                         |
| Automatic Capitalization | Off                           |
| Remove Keys              | Compose, Voice, Clipboard     |
</details>

<details><summary> App Info Settings </summary>

| App         | Unrestricted Battery | Appear on Top  | Default App  |
|-------------|----------------------|----------------|--------------|
| Termux      | ✅                   | ✅             | ❌           |
| Termux API  | ✅                   | ✅             | ❌           |
| Aurora Store| ❌                   | ❌             | ✅           |
</details>

<details><summary> One Hand Operation+ Configuration </summary>

| Gesture           | Short Swipe      | Long Swipe       |
|-------------------|------------------|------------------|
| Right Top         | Previous App     | Task Switcher    |
| Right Bottom      | Quick Tools      | Quick Launcher   |

| Option            | Value |
|-------------------|-------|
| S-Pen Gestures    | Off   |
| Long Swipe Delay  | 0ms   |
</details>

## Importing Data
- Acquire passwords in LocalSend
- Login to accounts
