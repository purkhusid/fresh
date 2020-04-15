#! /usr/bin/env bash

set -o pipefail
set -o errexit

rm -f $HOME/.zshrc
stow dotfiles -v -t $HOME
