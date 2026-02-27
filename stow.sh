#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset

### Symlink config
# Dotfiles
for dir in dotfiles/*/; do
	stow -v -R -d dotfiles -t "${HOME}" $(basename "$dir")
done

# Config files
stow -v -R --adopt -d config -t "${HOME}/.config/" .

# Scripts
mkdir -p "${HOME}/scripts" && stow -R -t "${HOME}/scripts" scripts

