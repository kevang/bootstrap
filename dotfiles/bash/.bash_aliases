# Bash
alias ..="cd .."
alias ...="cd ../.."
alias cd...="cd ../.."
alias cd..="cd .."
alias cp='cp -v'
alias findh="find . -name "
alias grep="rg --hidden --glob '!.git'"
alias gg="rg --hidden --glob '!.git'"
alias ll='eza -la --icons'
alias ls='eza --icons=always'
alias lt='eza --tree --level=1 --icons=always'
alias mv='mv -v'
alias shutdown='systemctl poweroff'

# Git
alias g='git'

# Python
alias python="python3"

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

# tldr
alias tl="tldr --list | grep \"^bat|^btm|^docker|^eza|^fc-list|^fd|^fzf|^git|^jq|^kubectl|^ncdu|^ripgrep|^tmux|^tree|^uv|^vim|^xh|^yay\" | sort -r | fzf --preview 'tldr {} --color always' | xargs tldr"
alias tll="tldr --list | grep \"^bat$|^btm$|^docker$|^docker-compose$|^eza$|^fc-list$|^fd$|^fzf$|^git$|^jq$|^kubectl$|^ncdu$|^ripgrep$|^tmux$|^tree$|^uv$|^xh$|^yay$\" | sort -r | fzf --preview 'tldr {} --color always' | xargs tldr"

# Starship
alias ctx='STARSHIP_CONFIG=~/.config/starship/starship_context.toml starship explain'

alias llm='echo "For the following, keep answers succinct and to the point. Do not ask follow-up questions. If I ask you to create or modify any code, do noy add comments to the code. Only show code that you updated/added." | ccat'
