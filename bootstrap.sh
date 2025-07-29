#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset

### Script functions
# Check if package is installed
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
	source "./scripts/arch.sh"
	if [[ $(cat /etc/*release | head -2 | grep -i arch) ]]; then
		sudo pacman -Sy
		echo "Installing Arch packages"
		packages=("bat" "fd" "figlet" "fzf" "git" "git-delta" "gum" "httpie" "jq" "libxml2" "ncdu" "neovim" "eza" "pyenv" "python-pipenv" "python-pipx" "python-poetry" "shellcheck" "stow" "tmux" "tree" "ttf-jetbrains-mono-nerd" "ttf-font-awesome" "unzip" "vim" "zsh")
		_installPackagesPacman "${packages[@]}"
		aur_packages=("antigen" "tmux-plugin-manager")
		yay -S --noconfirm $(printf "%s " "${aur_packages[@]}")
	fi
else
	echo "Distro ${1} not supported. Exiting..."
	exit 1
fi

# pipx ensurepath

# Tmux plugin manager
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || (
# 	cd ~/.tmux/plugins/tpm
# 	git pull
# )

### Symlink config
# Dotfiles
for dir in dotfiles/*/; do
	stow -v -R -d dotfiles -t "${HOME}" $(basename "$dir")
done

# Config files
stow -v -R -d config -t "${HOME}/.config/" .

# Scripts
mkdir -p "${HOME}/scripts" && stow -R -t "${HOME}/scripts" scripts

