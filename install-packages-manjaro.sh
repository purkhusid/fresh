#! /usr/bin/env bash

set -o pipefail
set -o errexit

sudo pacman -Syu --noconfirm \
  git \
  stow \
  vim \
  curl \
  wget \
  python \
  jdk11-openjdk \
  otf-fira-code \
  shellcheck \
  powerline-fonts \
  zsh \
  fzf \
  fd \
  neovim \
  bazel \
  docker \
  kitty \
  go \
  npm \
  yarn \
  dnsutils \
  fuse2 \
  fuse3 \
  rustup
  
# Oh My Zsh
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"

#Configure docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
if grep -q "^docker" /etc/group
then
  echo "Docker group already exists! Not creating it."
else
  sudo groupadd docker
fi
sudo usermod -aG docker ${USER}

#NodeJS global packages
sudo npm install -g typescript-language-server
sudo npm install -g @bazel/ibazel

#Rust configuration
rustup default stable
rustup update
cargo install sandboxfs

#Intellij
sudo snap install intellij-idea-community --classic --edge
sudo snap install rider --classic --edge

#VS Code
sudo snap install code --classic

#Slack
sudo snap install slack --classic
