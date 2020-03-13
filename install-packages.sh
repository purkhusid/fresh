#! /usr/bin/env bash

set -o pipefail
set -o errexit

sudo apt update -y
sudo apt install -y \
git \
stow \
vim \
apt-transport-https \
ca-certificates \
curl \
wget \
pkg-config \
zip \
g++ \
zlib1g-dev \
unzip \
python \
openjdk-8-jdk \
fonts-firacode \
shellcheck \
mesa-utils \
software-properties-common 

#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}

#Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir 
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications

#Alacritty
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt install alacritty

#Intellij
sudo snap install intellij-idea-community --classic --edge
sudo snap install rider --classic --edge

#VS Code
sudo snap install vscode --classic
