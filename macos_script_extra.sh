# Dev
# Intellij
brew install --cask intellij-idea
# PyCharm Community Edition (CE)
# brew install --cask pycharm-ce

# Non-dev

# Browsers
# Google Chrome
# brew install --cask google-chrome
# Brave
# brew install --cask brave-browser
# Firefox
# brew install --cask firefox
# Microsoft Edge
# brew install --cask microsoft-edge

# Google Drive: Client for the Google Drive storage service
# https://formulae.brew.sh/cask/google-drive
brew install --cask google-drive

# alt-tab: Utility to set up alt-tab to switch between windows
# https://formulae.brew.sh/cask/alt-tab#default
brew install --cask alt-tab

# Rectangle: Move and resize windows using keyboard shortcuts or snap areas
# https://formulae.brew.sh/cask/rectangle#default / https://rectangleapp.com/
brew install --cask rectangle

brew install --cask keepassxc

brew install --cask numi

# Keka: File archiver
# https://formulae.brew.sh/cask/keka#default
brew install --cask keka

# Spotify
# https://formulae.brew.sh/cask/spotify#default / https://www.spotify.com/
brew install --cask spotify

# Tomighty: Pomodoro desktop timer
# https://formulae.brew.sh/cask/tomighty#default / https://github.com/tomighty/tomighty-osx
brew install --cask tomighty

# Notion
# https://formulae.brew.sh/cask/notion#default / https://www.notion.so/
brew install --cask notion

# GrandPerspective: Graphically shows disk usage within a file system
# https://formulae.brew.sh/cask/grandperspective
brew install --cask grandperspective

# Terminal configuration
echo '\n' >> .zshrc
echo '# Disable share history between sessions' >> .zshrc
echo '# https://stackoverflow.com/questions/48873643/how-to-stop-zsh-from-merging-history-for-all-closing-tabs' >> .zshrc
echo '# https://github.com/ohmyzsh/ohmyzsh/issues/2537' >> .zshrc
echo 'unsetopt share_history' >> .zshrc
