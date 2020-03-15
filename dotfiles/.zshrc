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

#Go tooling
export GOBIN="$HOME/go/gobin"
export GOPATH="$HOME/go"
export PATH="$GOBIN:$GOPATH:$PATH"

#Extra envs
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export VISUAL=nvim
export EDITOR="$VISUAL"

# Theme settings
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
DEFAULT_USER=$USER
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs kubecontext aws)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# Fzf config
export FZF_DEFAULT_COMMAND="fdfind --hidden --follow --exclude .git --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NeoVIM config
export MYVIMRC="$HOME/.config/nvim/init.vim"

# Additional completions
fpath[1,0]=$HOME/.zsh_custom/completions/
# This way the completion script does not have to parse Bazel's options
# repeatedly.  The directory in cache-path must be created manually.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

source $ZSH/oh-my-zsh.sh

# Functions

# vf [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
vf() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}


# vfg [FUZZY PATTERN] - Open the selected git file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
vfg() {
  local files
  IFS=$'\n' files=($(git ls-files | fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Aliases
alias k='kubectl'
alias v='nvim'
