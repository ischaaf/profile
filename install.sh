#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

GIT_RE="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git\/(.+)$"
PROFILE_ROOT="$HOME/.profile.d"
PROFILE_STAGING="$PROFILE_ROOT/staging"
EXTERNAL_EXTENSIONS_DIR="$PROFILE_ROOT/external"
PLATFORM="$(uname)"

function _add_to_staging () {
  cp -vfrs "$PROFILE_ROOT/profile/$1/." "$PROFILE_STAGING/" || :
}

function _run_install () {
  for f in "$PROFILE_STAGING"/install/*; do
    echo "Running Post-Install: $f"
    $f
  done
}

function _link_home_dir () {
  cp -a "$PROFILE_STAGING/home/." "$HOME/"
}

function _parse_git_url () {
  local url="$1"
  local output="$2"
  if [[ $url =~ $GIT_RE ]]; then
    if [[ "$output" == protocol ]]; then
      echo "${BASH_REMATCH[1]}"
    elif [[ "$output" == separator ]]; then
      echo "${BASH_REMATCH[2]}"
    elif [[ "$output" == hostname ]]; then
      echo "${BASH_REMATCH[3]}"
    elif [[ "$output" == user ]]; then
      echo "${BASH_REMATCH[4]}"
    elif [[ "$output" == repo ]]; then
      echo "${BASH_REMATCH[5]}"
    elif [[ "$output" == extension ]]; then
      echo "${BASH_REMATCH[6]}"
    else
      echo "unknown output: $output" >&2
      return 1
    fi
  else
    echo "URL not a git url" >&2
    return 1
  fi
}

function _add_external_extension () {
  local repo extension name url clone_dir
  repo="$1"
  extension="$(_parse_git_url "$repo" extension)"
  name="$(_parse_git_url "$repo" repo)"
  url="$(echo "$repo" | sed "s/\/$extension//")"
  clone_dir="$EXTERNAL_EXTENSIONS_DIR/$name"

  if [[ -d "$clone_dir" ]]; then
    (
      cd "$clone_dir"
      git pull origin master --rebase
    )
  else
    git clone "$url" "$EXTERNAL_EXTENSIONS_DIR/$name"
  fi

  PROFILE_ROOT="$EXTERNAL_EXTENSIONS_DIR/$name" _add_to_staging "$extension"
}

function main () {
  EXTENSIONS=("$@")

  echo "Installing profile"
  echo "   PROFILE_ROOT=$PROFILE_ROOT"
  echo "PROFILE_STAGING=$PROFILE_STAGING"
  echo "       PLATFORM=$PLATFORM"
  echo "     EXTENSIONS=${EXTENSIONS[*]}"

  # Ensure staging dir
  mkdir -p "$PROFILE_STAGING"
  mkdir -p "$EXTERNAL_EXTENSIONS_DIR"

  # Prepare staging
  ## Install base
  _add_to_staging Base

  ## Install platform specific
  _add_to_staging "$PLATFORM"

  ## Install custom extensions
  for ext in "${EXTENSIONS[@]}"; do
    echo "adding extension files: $ext"
    if _parse_git_url "$ext" protocol >/dev/null 2>&1; then
      echo "external"
      _add_external_extension "$ext"
    else
      echo "internal"
      _add_to_staging "$ext"
    fi
  done

  # Link to Home directory
  if [ -n "${DRY_RUN:-}" ]; then
    echo "DRY_RUN set, not installing to home dir"
  else
    _link_home_dir
  fi

  # Run Post-Install scripts
  if [[ -n "${NO_INSTALL:-}" ]]; then
    echo "NO_INSTALL set, not running post install"
  else
    _run_install
  fi
}

main "$@"
