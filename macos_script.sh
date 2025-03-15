# 1. Install/Update Homebrew

which -s brew
if [[ $? != 0 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "\n" >> ~/.zprofile
    echo "# Homebrew" >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

# 2. Install Applications

echo "Install VSCode? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install --cask visual-studio-code
fi

echo "Install Postman? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install --cask postman
fi

echo "Install Postgres CLI? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install pgcli
fi

echo "Install Docker Desktop? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install --cask docker
fi

echo "Install iTerm2? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install --cask iterm2
fi

echo "Install autoenv? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    # autoenv: https://github.com/hyperupcall/autoenv
    brew install autoenv
    echo "\n" >> ~/.zshrc
    echo "# autoenv" >> ~/.zshrc
    echo "source $(brew --prefix autoenv)/activate.sh" >> ~/.zshrc
fi

echo "Install direnv? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    # direnv: https://direnv.net/
    brew install direnv
    echo "\n" >> ~/.zshrc
    echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
fi

echo "Install httpie? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install httpie
fi

echo "Install Slack? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install --cask slack
fi

echo "Install git? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install git
fi

# 3. Setup versions manager
which -s asdf
if [[ $? != 0 ]]; then
    echo "Installing asdf..."
    brew install asdf

    echo "\n" >> ~/.zshrc
    echo "# asdf" >> ~/.zshrc
    # Instructions: https://asdf-vm.com/guide/getting-started.html#_2-configure-asdf
    . $(brew --prefix asdf)/libexec/asdf.sh
    echo '. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.zshrc
    # 1. Add shims directory to path (required)
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
    echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> ~/.zshrc
    # 2. Set up shell completions (optional)
    # Completions are configured by either a ZSH Framework asdf plugin 
    # (like asdf for oh-my-zsh) or by doing the following:
    mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
    asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
    # Then add the following to your .zshrc:
    echo "# append completions to fpath" >> ~/.zshrc
    echo 'fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)' >> ~/.zshrc
    echo "# initialise completions with ZSH's compinit" >> ~/.zshrc
    echo "autoload -Uz compinit && compinit" >> ~/.zshrc

    asdf plugin add python
    asdf plugin add golang
    sadf plugin add nodejs
    asdf plugin add rust
    asdf plugin add yarn
fi

# 4. Setup Python
echo "Installing pipx..."
brew install pipx
pipx ensurepath

## Poetry: https://python-poetry.org/docs/#installing-with-the-official-installer
which -s poetry
if [[ $? != 0 ]]; then
    curl -sSL https://install.python-poetry.org | python3 -
    
    export PATH="$HOME/.local/bin:$PATH"
    echo '\n' >> ~/.zprofile
    echo "# poetry" >> ~/.zprofile
    # This is commented out because pipx already adds this to the PATH
    # echo 'export PATH="'$HOME'/.local/bin:$PATH"' >> ~/.zprofile
    poetry config virtualenvs.in-project false
    # poetry config virtualenvs.path ~/.virtualenvs

    # Install Poetry completions for Zsh
    poetry completions zsh > ~/.zfunc/_poetry
    echo "\n" >> ~/.zshrc
    echo "# poetry" >> ~/.zshrc
    echo 'fpath+=~/.zfunc' >> ~/.zshrc
    echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
else
    echo "Poetry is already installed"
fi

# 5. Setup Google Cloud SDK

brew list --cask google-cloud-sdk &>/dev/null
if [[ $? != 0 ]]; then
    brew install --cask google-cloud-sdk
    echo '\n' >> ~/.zshrc
    echo "# Google Cloud SDK" >> ~/.zshrc
    echo 'source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"' >> ~/.zshrc
    gcloud init --project spider-ef8f
    # Enable authentication to pull private Docker images from GCR
    gcloud components install docker-credential-gcr
    gcloud auth configure-docker
else
    brew upgrade --cask google-cloud-sdk
fi

# 6. Install Github CLI
brew install gh

# 7. Add extra handy commands
echo "\n" >> ~/.zshrc
echo "# Handy commands" >> ~/.zshrc
echo "alias clean_branches='git fetch --prune && git branch -vv | grep \": gone]\" | awk \"{print \\\$1}\" | xargs -I % git branch -D %'" >> ~/.zshrc
