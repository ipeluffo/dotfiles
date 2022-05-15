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
    code --install-extension ms-python.python
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

echo "Install nvm (and node)? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"
    source ~/.zshrc
    nvm install 16
fi

echo "Install yarn? [y/n]"
read confirmation
if [[ $confirmation == "y" ]]; then
    brew install yarn
fi

# 3. Setup Python

which -s pyenv
if [[ $? != 0 ]]; then
    brew install pyenv
    echo "\n" >> ~/.zprofile
    echo "# pyenv" >> ~/.zprofile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
    echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    pyenv install 3.9.7
    pyenv global 3.9.7
else
    brew list pyenv &>/dev/null && brew upgrade pyenv
fi

## Poetry: https://python-poetry.org/docs/master/#installation
which -s poetry
if [[ $? != 0 ]]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
    export PATH="/Users/$USER/.local/bin:$PATH"
    echo '\n' >> ~/.zprofile
    echo "# poetry" >> ~/.zprofile
    echo 'export PATH="/Users/'$USER'/.local/bin:$PATH"' >> ~/.zprofile
    poetry config virtualenvs.in-project false
    poetry config virtualenvs.path ~/.virtualenvs
else
    poetry self update
fi

# 4. Setup Google Cloud SDK

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
