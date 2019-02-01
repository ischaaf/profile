#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

PROFILE_ROOT="$HOME/.profile.d"
PROFILE_STAGING="$PROFILE_ROOT/staging"

PLATFORM="$(uname)"
EXTENSIONS=("$@")

echo "Installing profile"
echo "   PROFILE_ROOT=$PROFILE_ROOT"
echo "PROFILE_STAGING=$PROFILE_STAGING"
echo "       PLATFORM=$PLATFORM"
echo "     EXTENSIONS=${EXTENSIONS[*]}"

function _add_to_staging () {
  cp -vfrs "$PROFILE_ROOT/profile/$1/." "$PROFILE_STAGING/"
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

mkdir -p "$PROFILE_STAGING"
# Prepare staging
# Install base
_add_to_staging Base

# Install platform specific
_add_to_staging "$PLATFORM"

# Install custom extensions
for ext in "${EXTENSIONS[@]}"; do
  echo "adding extension files: $ext"
  _add_to_staging "$ext"
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
