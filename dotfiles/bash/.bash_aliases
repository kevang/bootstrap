# Bash
alias ..="cd .."
alias ...="cd ../.."
alias cd...="cd ../.."
alias cd..="cd .."
alias cp='cp -v'
alias findh="find . -name "
alias grep='rg --hidden'
# alias grep='grep --color=auto'
alias ll='eza -la --icons'
alias ls='eza --icons'
alias lt='eza --tree --level=1 --icons'
alias mv='mv -v'
alias shutdown='systemctl poweroff'

# Git
alias g='git'
alias gg='git grep'

# Tmux
alias tmuxa="tmux attach"
alias tmuxd="tmux detach"
alias tn="tmux neww 2> /dev/null || tmux"

# NeoVim
alias v='nvim'
alias vim='nvim'

# Vim
alias vw='vim -c VimwikiIndex'

# Kubernetes
alias kube='kubectl'
alias k='kubectl'

# SSH
alias ssh_hosts="grep -w -i -h Host ~/.ssh/*config | sed 's/Host//' | sort"
