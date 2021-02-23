export PATH="$HOME/bin:/usr/local/bin:$PATH"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Oh My Zsh plugins
plugins=(git kubectl aws kube-ps1 zsh-autosuggestions fzf)

# Set ZSH_CUSTOM directory
# Used for custom themes and plugins
ZSH_CUSTOM="$HOME/.zsh_custom"

# History settings
setopt share_history
HISTSIZE="200000"
SAVEHIST="200000"
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

HISTSIZE="200000"
SAVEHIST="200000"
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

#User specific binaries
export PATH="$HOME/bin:$PATH"

#Go tooling
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$GOBIN:$GOPATH:$PATH"

#Rust tooling
export PATH="$HOME/.cargo/bin:$PATH"

#NodeJS
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#.Net Core
export PATH="$HOME/.dotnet/tools:$PATH"

# webOS CLI
export PATH="/usr/local/share/webOS_TV_SDK/CLI/bin:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Opam
eval $(opam env)

#Extra envs
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export VISUAL=nvim
export EDITOR="$VISUAL"
export GITHUB_TOKEN="$(cat $HOME/.config/hub)"

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

function k8() {
	local k8_config
	if [[ $1 == "none" ]]; then
		unset KUBECONFIG
		return
	fi

	if [[ $# -eq 0 ]]; then
		if [[ -z "${KUBECONFIG}" ]]; then
			echo "No kubernetes config active" 1>&2
		else
			basename "${KUBECONFIG}"
		fi
		return
	fi
	if [[ $# -ne  1 ]]; then
		echo "Usage k8 <cluster>" 1>&2
		return
	fi
	k8_config="$HOME/.kube/$1"
	if [[ ! -e $k8_config ]]; then
		echo "KUBECONFIG \"$k8_config\" does not exist" 1>&2
		return
	fi
	export KUBECONFIG="$k8_config"
}

function _k8() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local configs
	configs=""
	for file in "$HOME/.kube"/*
	do
		if [[ -d "$file" ]]; then
			continue
		fi
		configs="$configs $(basename "$file")"
	done
	COMPREPLY=( $(compgen -W "$configs" -- "$cur" ) )
}
complete -o nospace -F _k8 k8

# Aliases
alias tfswitch='tfswitch -b $HOME/bin/terraform'
#alias code='code-insiders'
alias k='kubectl'
alias v='nvim'
