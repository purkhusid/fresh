#! /usr/bin/env bash

set -o pipefail
set -o errexit
set -x
 
sudo dnf install -y \
  git \
  stow \
  vim \
  curl \
  wget \
  java-11-openjdk-devel.x86_64 \
  fira-code-fonts \
  ShellCheck \
  powerline \
  powerline-fonts \
  zsh \
  fzf \
  fd-find \
  neovim \
  python3-neovim \
  golang \
  nodejs \
  opam \
  python3-devel \
  python-devel \
  libffi-devel \
  dotnet-sdk-3.1 \
  gcc-c++.x86_64 \
  dotnet-runtime-3.1

# Bazel
dnf install dnf-plugins-core
dnf copr enable vbatts/bazel
dnf install -y bazel3

# Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo dnf install -y yarn

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Create bin folder for user specific binaries
mkdir -p $HOME/bin

# Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

# Oh My Zsh
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"

#Configure docker
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade
sudo dnf install -y moby-engine docker-compose
sudo systemctl enable docker
if grep -q "^docker" /etc/group
then
  echo "Docker group already exists! Not creating it."
else
  sudo groupadd docker
fi
sudo usermod -aG docker ${USER}

# Increase file watchers
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

#NodeJS global packages
sudo npm install -g typescript-language-server
sudo npm install -g @bazel/ibazel

#Rust configuration and global packages
rustup default stable
rustup update

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

#Kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#Install Snap
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap

#Intellij
sudo snap install intellij-idea-community --classic --channel=2020.1.4/stable
sudo snap install rider --classic --edge

#VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

#Slack
sudo snap install slack --classic
