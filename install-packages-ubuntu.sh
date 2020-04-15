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
openjdk-11-jdk \
fonts-firacode \
shellcheck \
mesa-utils \
fonts-powerline \
zsh \
fzf \
fd-find \
neovim \
software-properties-common 

# Oh My Zsh
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"

#Bazel
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update
sudo apt install -y bazel

#Docker
sudo snap install docker
if grep -q "^docker" /etc/group
then
  echo "Docker group already exists! Not creating it."
else
  sudo groupadd docker
fi
sudo usermod -aG docker ${USER}

#Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -sf ~/.local/kitty.app/bin/kitty /usr/local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop

#Golang
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

#NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -o- -L https://yarnpkg.com/install.sh | bash
sudo apt-get install -y nodejs
sudo npm install -g typescript-language-server
sudo npm install -g @bazel/ibazel

#Intellij
sudo snap install intellij-idea-community --classic --edge
sudo snap install rider --classic --edge

#VS Code
sudo snap install code --classic
