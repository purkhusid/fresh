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
  rustup \
  dotnet-runtime \
  dotnet-sdk \
  virtualbox \
  peek \
  opam \
  watchman \
  chromium

# Create bin folder for user specific binaries
mkdir -p $HOME/bin

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

# Increase file watchers
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/50-max_user_watches.conf && sudo sysctl --system

#NodeJS global packages
sudo npm install -g typescript-language-server
sudo npm install -g @bazel/ibazel

#Rust configuration and global packages
rustup default stable
rustup update
cargo install sandboxfs

#Golang configuration and global packages
go get github.com/bazelbuild/buildtools/buildifier
go get github.com/bazelbuild/buildtools/buildozer
go get github.com/bazelbuild/bazelisk

#Global pip packages
pip3 install pynvim

#Configure opam for use with Bucklescript/Reason
opam init
opam switch create 4.06.1
opam install merlin
opam install reason

#Terraform
curl -sL https://github.com/warrensbox/terraform-switcher/releases/download/0.7.817/terraform-switcher_0.7.817_linux_amd64.tar.gz -o tfswitch.tar.gz
tar -zxvf tfswitch.tar.gz tfswitch
chmod +x tfswitch
mv tfswitch $HOME/bin/tfswitch
rm tfswitch.tar.gz

#Kubeclt
sudo packman -U https://archive.archlinux.org/packages/k/kubectl/kubectl-1.14.3-1-x86_64.pkg.tar.xz

#Intellij
sudo snap install intellij-idea-community --classic --edge
sudo snap install rider --classic --edge

#VS Code
sudo snap install code-insiders --classic

#Slack
sudo snap install slack --classic
