#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

PROFILE_ROOT="$HOME/.profile.d"
PROFILE_STAGING="$PROFILE_ROOT/staging"

while read -r f; do
  HOME_FILE="${f/staging\/home/$HOME}"
  DIR="$(dirname "$HOME_FILE")"
  unlink "$HOME_FILE"
  if [[ "$DIR" != "$HOME" ]]; then
    rmdir "$DIR" || : # remove the dir if it is empty
  fi
done < <(find staging/home -type l)
