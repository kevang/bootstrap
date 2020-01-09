#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset

### Install packages
if [[ $1 = "ubuntu" ]]; then
  echo "Installing Ubuntu packages"
  sudo apt-get -q update &&
    sudo add-apt-repository ppa:jonathonf/vim &&
    sudo apt-get -q install \
      stow \
      tmux rxvt-unicode-256color \
      vim \
      git \
      fonts-roboto \
      tree shellcheck \
      jq libxml2-utils \
      lsyncd

  # Disable certain shortcuts
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
  gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]" # disable Alt+F1

elif [[ $1 = "arch" ]]; then
  :
else
  echo "Distro ${1} not supported. Exiting..."
  exit 1
fi
# install vscode
# install perl scripts

# Tmux plugin manager
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### Symlink config
# Dotfiles
for dir in dotfiles/*/
do
  stow -v -R -d dotfiles -t "${HOME}" $(basename $dir)
done

# Scripts
stow -v -R -t "${HOME}/scripts" scripts

# VS Code
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    stow -v -R -d config -t "${HOME}/.config/Code/User" vscode
elif [[ "$OSTYPE" == "darwin"* ]]; then
    stow -v -R -d config -t "${HOME}/Library/Application Support/Code/User" vscode
fi
