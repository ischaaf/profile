#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

function _verbose_echo () {
  if [ ! -z "${PROFILE_VERBOSE:-}" ]; then
    echo "$@"
  fi
}

PROFILE_ROOT="$HOME/.profile.d"
PROFILE_STAGING="$PROFILE_ROOT/staging"

PLATFORM="$(uname)"
EXTENSIONS=("$@")

_verbose_echo "Installing profile"
_verbose_echo "PROFILE_ROOT=$PROFILE_ROOT"
_verbose_echo "PROFILE_STAGING=$PROFILE_STAGING"
_verbose_echo "PLATFORM=$PLATFORM"
_verbose_echo "EXTENSIONS=${EXTENSIONS[*]}"

function _add_to_staging () {
  local name home_path source_path
  name="$1"
  home_path="$PROFILE_ROOT/profile/$name/home"
  source_path="$PROFILE_ROOT/profile/$name/source"

  # shellcheck disable=SC2015
  test -d "$home_path" && cp -frs "$home_path" "$PROFILE_STAGING/" || :
  # shellcheck disable=SC2015
  test -d "$source_path" && cp -frs "$source_path" "$PROFILE_STAGING/" || :
}


mkdir -p "$PROFILE_STAGING"
# Prepare staging
# Install base
_add_to_staging Base
_add_to_staging "$PLATFORM"

for ext in "${EXTENSIONS[@]}"; do
  echo "adding extension files: $ext"
  _add_to_staging "$ext"
done

if [ -n "${DRY_RUN:-}" ]; then
  echo "DRY_RUN set, not installing to home dir"
else
  cp -a "$PROFILE_STAGING/home/." "$HOME/"
fi
