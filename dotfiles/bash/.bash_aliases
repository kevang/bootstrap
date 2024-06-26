# Bash
alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."
alias cd...="cd ../.."
#alias ls='gls --color=auto --group-directories-first'
# alias ls='ls --color -h --group-directories-first --format=horizontal'
# alias ll='ls -lha'
alias ls='eza --icons'
alias ll='eza -la --icons'
alias lt='eza --tree --level=1 --icons'
alias cp='cp -v'
alias mv='mv -v'
alias grep='grep --color=auto'
alias findh="find . -name "
alias shutdown='systemctl poweroff'

# Git
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
