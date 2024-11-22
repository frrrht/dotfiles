# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/ferhat/.zsh/completions:"* ]]; then export FPATH="/Users/ferhat/.zsh/completions:$FPATH"; fi
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path configuration
export PATH="$HOME/.composer/vendor/bin:$PATH" # Global Composer packages
export PATH="$HOME/.config/phpmon/bin:$PATH" # PHPMonitor binaries
export PATH="$HOME/Library/Python/3.9/bin:$PATH" # Python binaries

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# ZSH Plugin configuration
plugins=(git)

# Sourcing other files
source $ZSH/oh-my-zsh.sh
source $HOME/.frrrht-helpers.sh

# NVM configuration
export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Initialize Zioxide
eval "$(zoxide init zsh)"

# Pretty print device info
fastfetch
