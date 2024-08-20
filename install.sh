#!/bin/sh

DOTFILES_DIR="$HOME/dotfiles"

if [[ "$(pwd)" != $DOTFILES_DIR ]]; then
  echo "\nCannot proceed with installation, pwd invalid."
  echo "Please run this install script inside the following directory:"
  echo "\t$DOTFILES_DIR\n"
  exit 0
fi

echo "Setting up your Mac..."

# Install XCode
xcode-select --install

# Remove macOS motd
touch $HOME/.hushlogin

# Basic filesystem setup
mkdir -p $HOME/Development
mkdir -p $HOME/.nvm

# Check for Homebrew and install if we don't have it
if test ! "$(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check for oh-my-zsh and install if we don't have it
if test ! "$(which omz)"; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Check for Laravel installer and install if we don't have it
if test ! "$(which laravel)"; then
  composer global require laravel/installer
fi

# Check for Valet and install if we don't have it
if test ! "$(which valet)"; then
  composer global require laravel/valet
  "$HOME/.composer/vendor/bin/valet" install
  "$HOME/.composer/vendor/bin/valet" trust
fi

# Check for Node and install if we don't have it
if test ! "$(which node)"; then
  nvm install latest
  nvm use latest
fi

# Stow all directories to the home
stow helpers -t $HOME

rm -f $HOME/.zshrc
stow zsh -t $HOME