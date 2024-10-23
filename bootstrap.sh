#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset

### Script functions
# Check if package is installed
_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# Install required packages
_installPackagesPacman() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        echo "All pacman packages are already installed.";
        return;
    fi;
    printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

# Install Yay
_installYay() {
    if sudo pacman -Qs yay > /dev/null ; then
        echo "yay is already installed!"
    else
        echo "yay is not installed. Will be installed now!"
        _installPackagesPacman "base-devel"
        SCRIPT=$(realpath "$0")
        temp_path=$(dirname "$SCRIPT")
        echo $temp_path
        git clone https://aur.archlinux.org/yay-git.git ~/yay-git
        cd ~/yay-git
        makepkg -si
        cd $temp_path
        echo "yay has been installed successfully."
    fi
}

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

# Apply Xresources
# xrdb ~/.Xresources

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

