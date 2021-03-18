# Apps
Chrome
Brave browser
Visual Studio Code and extensions:
    1. Python: ms-python.python
    2. Visual Studio IntelliCode
    3. Install as CLI: https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line
IntelliJ: www.jetbrains.com/intellij
Docker Desktop: 
Rectangle: 
Postgres.app: https://postgresapp.com/
Android file transfer: https://www.android.com/intl/en_us/filetransfer/
FileZilla (SFTP client): https://filezilla-project.org/download.php?type=client
FreeFileSync (Sync files between drives): https://freefilesync.org/

# Terminal:
1. iTerm2
2. Oh My Zsh: https://github.com/ohmyzsh/ohmyzsh
3. zsh-autosuggestions and zsh-syntax-highlighting (option 2 for highlighting: install with homebrew)
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
nano ~/.zshrc
plugins=(git zsh-autosuggestions)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```
4. Homebrew: https://brew.sh

# Python
```shell
brew install pyenv
pyenv install x.y.z
# define PYENV_ROOT=$HOME/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
# add pyenv oh my zsh plugin into .zshrc
brew install pipx
export PIPX_DEFAULT_PYTHON="$PYENV_ROOT/shims/python"
echo 'export PIPX_DEFAULT_PYTHON="$PYENV_ROOT/shims/python"' >> ~/.zshrc
pipx ensurepath
poetry (native installer)
```

How to reinstall all packages in pipx:
```shell
pyenv install 3.9.1
pyenv shell 3.9.1
pipx reinstall-all
```

# Optional
LibreOffice
Slack

# Not compatible with M1 (yet)
1. alt+tab: https://alt-tab-macos.netlify.app/
2. Postman
3. RescueTime
4. Spotify

# Interesting links
* https://technofob.com/2020/12/24/the-ultimate-mac-m1-terminal-iterm2-oh-my-zsh-zsh-syntax-highlighting/
* Guides to use homebrew on M1: 
    * https://wnderlvst.com/stories/5101f1ca-a1c8-4dfc-b469-ccf4dae0d823
    * https://www.reddit.com/r/MacOS/comments/kghwef/best_method_to_install_homebrew_on_m1/

# Installation with command line
```shell
# Browsers
## Google Chrome
brew install --cask google-chrome
## Brave
brew install --cask brave-browser
## Firefox
brew install --cask firefox
## Vivaldi
brew install --cask vivaldi
## Microsoft Edge
brew install --cask microsoft-edge
# KeepassXC
brew install --cask keepassxc
# Visual Studio Code
brew install --cask visual-studio-code
# IntelliJ IDEA Ultimate
brew install --cask intellij-idea
# PyCharm Community Edition (CE)
brew install --cask pycharm-ce
# Numi (calculator)
brew install --cask numi
# qBittorrent
brew install --cask qbittorrent
# Macdown: Markdown editor
brew install --cask macdown
# GrandPerspective: Graphically shows disk usage within a file system
# https://formulae.brew.sh/cask/grandperspective
brew install --cask grandperspective
# alt-tab: Utility to set up alt-tab to switch between windows
# https://formulae.brew.sh/cask/alt-tab#default
brew install --cask alt-tab
# Google Photos Backup And Sync: 
# https://formulae.brew.sh/cask/google-photos-backup-and-sync#default
brew install --cask google-photos-backup-and-sync
# Google Drive: Client for the Google Drive storage service
# https://formulae.brew.sh/cask/google-drive
brew install --cask google-drive
# Bartender: Menu bar icon organizer
# https://formulae.brew.sh/cask/bartender#default
brew install --cask bartender
# iStats Menus: System monitoring app
# https://formulae.brew.sh/cask/istat-menus#default
brew install --cask istat-menus
# Telegram for macOS
# https://formulae.brew.sh/cask/telegram#default / https://macos.telegram.org/
brew install --cask telegram
# Keka: File archiver
# https://formulae.brew.sh/cask/keka#default
brew install --cask keka
# Keybase: End-to-end encryption software
# https://formulae.brew.sh/cask/keybase#default
brew install --cask keybase
# NordVPN: VPN client for secure internet access and private browsing
# https://formulae.brew.sh/cask/nordvpn#default
brew install --cask nordvpn
# Real VNC Server
# https://formulae.brew.sh/cask/vnc-server#default
brew install --cask vnc-server
# Real VNC Viewer: Remote desktop application focusing on security
# https://formulae.brew.sh/cask/vnc-viewer#default
brew install --cask vnc-viewer
# Rectangle: Move and resize windows using keyboard shortcuts or snap areas
# https://formulae.brew.sh/cask/rectangle#default / https://rectangleapp.com/
brew install --cask rectangle
# RescueTime: Time optimising application
# https://formulae.brew.sh/cask/rescuetime#default
brew install --cask rescuetime
# Spotify
# https://formulae.brew.sh/cask/spotify#default / https://www.spotify.com/
brew install --cask spotify
# TeamViewer
# https://formulae.brew.sh/cask/teamviewer#default / https://www.teamviewer.com/
brew install --cask teamviewer
# Tomighty: Pomodoro desktop timer
# https://formulae.brew.sh/cask/tomighty#default / https://github.com/tomighty/tomighty-osx
brew install --cask tomighty
# VLC media player
# https://formulae.brew.sh/cask/vlc#default / https://www.videolan.org/vlc/
brew install --cask vlc
# Notion
# https://formulae.brew.sh/cask/notion#default / https://www.notion.so/
brew install --cask notion
```

# Dev
```shell
# Golang
brew install go
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /Users/ignacio/.gvm/scripts/gvm
gvm install go1.16.2
gvm use go1.16.2 --default
brew uninstall go

# pgcli
brew install pgcli

# desktop apps
## Postman
brew install --cask postman
# pgAdmin4
brew install --cask pgadmin4
# Cyberduck
brew install --cask cyberduck
# Tunnelblick: VPN client
# https://formulae.brew.sh/cask/tunnelblick#default / https://www.tunnelblick.net/
brew install --cask tunnelblick
```
