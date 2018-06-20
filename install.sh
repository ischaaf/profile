#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

PROFILE_PATH="$HOME/.profile.d"
PLATFORM="$(uname)"
test -d "$HOME/bin" || mkdir "$HOME/bin"

# TODO dotfiles/binfiles with the same name for different os's will collide (first one wins)

function _link_dotfiles () {
  local base_path="$1"
  for f in $base_path/*; do
    if [ -d $f ]; then
      test -d "$HOME/.$(basename $f)" || mkdir "$HOME/.$(basename $f)"
      for g in $f/*; do
        test -f "$HOME/.$(basename $f)/$(basename $g)" || ln -s "$g" "$HOME/.$(basename $f)/$(basename $g)"
      done
      continue
    fi
    test -f "$HOME/.$(basename $f)" || ln -s "$f" "$HOME/.$(basename $f)"
  done
}
function _link_bin () {
  local base_path="$1"
  for f in $base_path/*; do
    test -d $f && continue
    test -f "$HOME/bin/$(basename $f)" || ln -s "$f" "$HOME/bin/$(basename $f)"
  done
}

_link_dotfiles "${PROFILE_PATH}/base/dotfiles"
_link_dotfiles "${PROFILE_PATH}/${PLATFORM}/dotfiles"

_link_bin "${PROFILE_PATH}/base/bin"
_link_bin "${PROFILE_PATH}/${PLATFORM}/bin"
