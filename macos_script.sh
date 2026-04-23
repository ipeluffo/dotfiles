#!/bin/zsh
set -euo pipefail

# Helper: prompt user and run command if confirmed
confirm_and_run() {
    local prompt_msg="$1"
    shift
    echo "$prompt_msg [y/n]"
    read confirmation
    if [[ "$confirmation" == "y" ]]; then
        "$@"
    fi
}

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

confirm_and_run "Install VSCode?" brew install --cask visual-studio-code
confirm_and_run "Install Postman?" brew install --cask postman
confirm_and_run "Install Postgres CLI?" brew install pgcli
confirm_and_run "Install Docker Desktop?" brew install --cask docker
confirm_and_run "Install iTerm2?" brew install --cask iterm2

echo "Install autoenv? [y/n]"
read confirmation
if [[ "$confirmation" == "y" ]]; then
    # autoenv: https://github.com/hyperupcall/autoenv
    brew install autoenv
    echo "\n" >> ~/.zshrc
    echo "# autoenv" >> ~/.zshrc
    echo "source $(brew --prefix autoenv)/activate.sh" >> ~/.zshrc
fi

echo "Install direnv? [y/n]"
read confirmation
if [[ "$confirmation" == "y" ]]; then
    # direnv: https://direnv.net/
    brew install direnv
    echo "\n" >> ~/.zshrc
    echo "# direnv" >> ~/.zshrc
    echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
fi

confirm_and_run "Install httpie?" brew install httpie
confirm_and_run "Install Slack?" brew install --cask slack
confirm_and_run "Install git?" brew install git

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
    asdf plugin add nodejs
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
    # Note: compinit is already initialized by asdf setup above
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

    echo "Enter your GCP project ID (or press Enter for 'spider-ef8f'):"
    read gcp_project
    gcp_project="${gcp_project:-spider-ef8f}"
    gcloud init --project "$gcp_project"

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

# 8. Install AI Tools

confirm_and_run "Install Gemini CLI?" brew install gemini-cli
confirm_and_run "Install Copilot CLI?" brew install copilot-cli

echo "Install Claude Code CLI? [y/n]"
read confirmation
if [[ "$confirmation" == "y" ]]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo "Install Opencode CLI? [y/n]"
read confirmation
if [[ "$confirmation" == "y" ]]; then
    curl -fsSL https://opencode.ai/install | bash
fi

confirm_and_run "Install Opencode desktop app?" brew install --cask opencode-desktop

confirm_and_run "Install OpenAI Codex CLI?" brew install codex
