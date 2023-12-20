###Navigation
# Fuzzy finding of child directory && cd
fdd() {
  local base dir dest
  base="${1}"
  dir="$(find $base/* -maxdepth 0 -type d -print 2> /dev/null | sed 's!.*/!!' | sort -r | fzf-tmux +m)"

  dest="${base}/${dir}"
  echo "$dest"
  if [[ ! -z "$dest" ]]; then
    cd "${dest}"
  fi
}

# Fuzzy find directory in ~/dev directory && cd
dev() {
  local base
  base="${HOME}/dev"

  fdd "$base"
  tmux rename-window "$(basename $(pwd))"
}

# mkcd function
mkcd() {
  mkdir -p "$1"; cd "$1"
}

# mktmp function
mktmp() {
  temp_dir=$(head /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 | head -c 13)
  mkdir -p "/tmp/${temp_dir}"
  cd "/tmp/${temp_dir}"
}

### Git
# Checkout git branch/tag
fco() {
  local tags branches target

  tags="$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}')" || return

  branches="$(git branch --all \
      | grep -v HEAD | sed 's/\* /\*/' | sed 's#remotes/[^/]*/##' | sort -u \
      | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}'
  )" || return

  target="$(printf '%s\n%s' "$branches" "$tags" \
      | fzf-tmux -- --no-hscroll --ansi -d '\t' -n 2 -q "$*" )" || return
  
  git checkout "$(echo "$target" | awk '{print $2}')"
}

### Python
# Venv functions
export VENV_HOME="${HOME}/.venv"
[[ -d ${VENV_HOME} ]] || mkdir "${VENV_HOME}"

venv() {
  if [ $# -eq 0 ]
    then
      venv_name="${PWD##*/}"
    else
      venv_name="$1"
  fi

  echo "Activating venv ${VENV_HOME}/${venv_name}"
  source "${VENV_HOME}/${venv_name}/bin/activate"
}

mkvenv() {
  if [ $# -eq 0 ]
    then
      venv_name="${PWD##*/}"
    else
      venv_name="$1"
  fi

  echo "Creating venv ${VENV_HOME}/${venv_name}"
  python3 -m venv "${VENV_HOME}/${venv_name}" && venv "${venv_name}"
}

rmvenv() {
  if [ $# -eq 0 ]
    then
      venv_name="${PWD##*/}"
    else
      venv_name="$1"
  fi

  echo "Removing venv ${VENV_HOME}/${venv_name}"
  rm -r "${VENV_HOME}/${venv_name}"
}
