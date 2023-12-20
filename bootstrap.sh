#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset

### Install packages
if [[ $1 = "ubuntu" ]]; then
	echo "Installing Ubuntu packages"
	packages=("fonts-roboto" "git" "jq" "libxml2-utils" "rxvt-unicode-256color" "stow" "tmux" "tree" "shellcheck" "vim")
	sudo apt-get -q update &&
		sudo add-apt-repository ppa:jonathonf/vim &&
		sudo apt-get -q install $(printf "%s " "${packages[@]}")
	# lsyncd
	# Disable certain shortcuts
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
	gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]" # disable Alt+F1
elif [[ $1 = "arch" ]]; then
	if [[ $(cat /etc/*release | head -1 | grep -i arch) ]]; then
		echo "Installing Arch packages"
		packages=("bat" "code" "fd" "git" "httpie" "jq" "libxml2" "ncdu" "neovim" "pyenv" "rxvt-unicode" "shellcheck" "stow" "tmux" "tree" "ttf-jetbrains-mono-nerd" "vim" "wezterm" "xclip")
		sudo pacman -S --noconfirm $(printf "%s " "${packages[@]}")
		# git clone https://aur.archlinux.org/yay.git &&
		#  cd yay && makepkg -si
		aur_packages=("cheat" "git-delta" "urxvt-perls" "urxvt-fullscreen" "urxvt-resize-font-git" "ttf-roboto-mono-nerd")
		yay -S --noconfirm $(printf "%s " "${aur_packages[@]}")
	fi
else
	echo "Distro ${1} not supported. Exiting..."
	exit 1
fi

# Apply Xresources
xrdb ~/.Xresources

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || (
	cd ~/.tmux/plugins/tpm
	git pull
)

### Symlink config
# Dotfiles
for dir in dotfiles/*/; do
	stow -v -R -d dotfiles -t "${HOME}" $(basename "$dir")
done

# Scripts
mkdir -p "${HOME}/scripts" && stow -v -R -t "${HOME}/scripts" scripts

# NeoVim
stow -v -R -d config -t "${HOME}/.config/nvim" nvim

# VS Code
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	stow -v -R -d config -t "${HOME}/.config/Code/User" vscode
elif [[ "$OSTYPE" == "darwin"* ]]; then
	stow -v -R -d config -t "${HOME}/Library/Application Support/Code/User" vscode
fi

# Cheat
stow -v -R -d config -t "${HOME}/.config/cheat" cheat
