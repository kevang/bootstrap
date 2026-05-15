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
  venv_name="${PWD##*/}"

  echo "Activating venv ${VENV_HOME}/${venv_name}"
  source "${VENV_HOME}/${venv_name}/bin/activate"
}

mkvenv() {
  venv_name="${PWD##*/}"

  if [ $# -ge 1 ]; then
    python_version="$1"
  else
    python_version="3.11"
  fi

  echo "Creating venv ${VENV_HOME}/${venv_name} with Python ${python_version}"
  uv venv "${VENV_HOME}/${venv_name}" --python "${python_version}" && \
    source "${VENV_HOME}/${venv_name}"/bin/activate && \
    export UV_PROJECT_ENVIRONMENT="${VENV_HOME}/${venv_name}"
}

rmvenv() {
  venv_name="${PWD##*/}"

  echo "Removing venv ${VENV_HOME}/${venv_name}"
  rm -r "${VENV_HOME}/${venv_name}"
}

ccat() {
  if command -v pbcopy >/dev/null; then
    pbcopy
  elif command -v wl-copy >/dev/null; then
    wl-copy
  elif command -v xclip >/dev/null; then
    xclip -selection clipboard
  else
    echo "No clipboard utility found (pbcopy, wl-copy, xclip)" >&2
    return 1
  fi
}

pip() { echo "Direct pip usage is disabled: use 'uv pip'"; return 1; }
pip3() { echo "Direct pip usage is disabled: use 'uv pip'"; return 1; }
