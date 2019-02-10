#! /usr/bin/env bash

set -o pipefail
set -o errexit

sudo apt update -y
sudo apt install -y \
git \
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
software-properties-common 

#Drivers
sudo ubuntu-drivers autoinstall

#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}

#VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update -y
sudo apt install -y code

#Steam
sudo add-apt-repository multiverse
sudo apt update -y
sudo apt install -y steam

#Intellij
sudo snap install intellij-idea-community --classic --edge
sudo snap install rider --classic --edge

#Spotify
sudo snap install spotify

#Slack
sudo snap install slack --classic
