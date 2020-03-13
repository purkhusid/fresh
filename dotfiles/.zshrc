export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Oh My Zsh plugins
plugins=(git kubectl aws kube-ps1 zsh-autosuggestions fzf)

# Set ZSH_CUSTOM directory
# Used for custom themes and plugins
ZSH_CUSTOM="$HOME/.zsh_custom"

# History settings
HISTSIZE="200000"
SAVEHIST="200000"
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

HISTSIZE="200000"
SAVEHIST="200000"
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

#Extra envs
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export VISUAL=vim
export EDITOR="$VISUAL"

# Theme settings
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
DEFAULT_USER=$USER
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs kubecontext aws)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

source $ZSH/oh-my-zsh.sh

# Aliases
alias k='kubectl'
