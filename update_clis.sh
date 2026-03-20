#!/bin/zsh

# Enable command printing
set -x

# Helper: run a command only if it exists
run_if_exists() {
    local cmd="$1"
    shift
    if command -v "$cmd" &>/dev/null; then
        "$@"
    else
        echo "Skipping: $cmd not found"
    fi
}

# Homebrew
# Update Homebrew
brew update
# Update all installed packages
brew upgrade

# gcloud
run_if_exists gcloud gcloud components update

# asdf
# asdf is updated via homebrew
if command -v asdf &>/dev/null; then
    echo "Updating asdf plugins..."
    asdf plugin update --all
fi

# Github CLI
if command -v gh &>/dev/null && gh extension list 2>/dev/null | grep -q gh-copilot; then
    gh extension upgrade gh-copilot
fi

# OMZ
if [[ -d "$ZSH" ]]; then
    "$ZSH/tools/upgrade.sh"
fi

# uv
run_if_exists uv uv self update

# Claude Code
run_if_exists claude claude update

# Opencode CLI
run_if_exists opencode opencode upgrade

# Check if ~/.local/bin is in $PATH and create symlink if needed
if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
  LOCAL_BIN="$HOME/.local/bin"
  LINK_TARGET="$LOCAL_BIN/update_clis"
  if [[ ! -L "$LINK_TARGET" ]]; then
    read "REPLY?Symlink $LINK_TARGET does not exist. Create it? (y/n) "
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      mkdir -p "$LOCAL_BIN"
      ln -s "${0:A}" "$LINK_TARGET"
      echo "Symlinked to $LINK_TARGET"
    fi
  fi
fi
