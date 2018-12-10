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
EXTENSIONS="$@"

_verbose_echo "Installing profile"
_verbose_echo "PROFILE_ROOT=$PROFILE_ROOT"
_verbose_echo "PROFILE_STAGING=$PROFILE_STAGING"
_verbose_echo "PLATFORM=$PLATFORM"
_verbose_echo "EXTENSIONS=$EXTENSIONS"


# Build staging dir of files



# function _link_dotfiles () {
#   local base_path="$1"
#   _verbose_echo "_link_dotfiles: $base_path"
#   for f in $base_path/*; do
#     if [ -d $f ]; then
#       _verbose_echo "  _link_dotfiles (subfolder): $f"
#       test -d "$HOME/.$(basename $f)" || mkdir "$HOME/.$(basename $f)"
#       for g in $f/*; do
#         _verbose_echo "    Linking dotfile: $g"
#         test -f "$HOME/.$(basename $f)/$(basename $g)" || ln -s "$g" "$HOME/.$(basename $f)/$(basename $g)"
#       done
#       continue
#     fi
#     _verbose_echo "  Linking dotfile: $f"
#     test -f "$HOME/.$(basename $f)" || ln -s "$f" "$HOME/.$(basename $f)"
#   done
# }
#
# function _post_install () {
#   local base_path="$1"
#   _verbose_echo "_post_install: $base_path"
#   for f in $base_path/*; do
#     _verbose_echo "  Running install script: $f"
#     $f
#   done
# }
#
# function _link_dotconfig () {
#   local base_path="$1"
#   _verbose_echo "_link_dotconfig: $base_path"
#   for d in $base_path/*; do
#     local dirpath
#     dirpath="$HOME/.config/$(basename $d)"
#     mkdir -p "$dirpath"
#     for f in $d/*; do
#       test -d $f && continue
#       _verbose_echo "  Linking dotconfig: $f"
#       test -f "$dirpath/$(basename $f)" || ln -s "$f" "$dirpath/$(basename $f)"
#     done
#   done
# }
#
# function _link_bin () {
#   local base_path="$1"
#   _verbose_echo "_link_bin: $base_path"
#   for f in $base_path/*; do
#     test -d $f && continue
#     _verbose_echo "  Linking bin: $f"
#     test -f "$HOME/bin/$(basename $f)" || ln -s "$f" "$HOME/bin/$(basename $f)"
#   done
# }

function _add_to_staging () {
  local name home_path source_path
  name="$1"
  home_path="$PROFILE_ROOT/profile/$name/home"
  source_path="$PROFILE_ROOT/profile/$name/source"
  test -d "$home_path" && cp -frs "$home_path" "$PROFILE_STAGING/" || :
  test -d "$source_path" && cp -frs "$source_path" "$PROFILE_STAGING/" || :
}


mkdir -p "$PROFILE_STAGING"
# Prepare staging
# Install base
_add_to_staging Base
_add_to_staging "$PLATFORM"

for ext in "$EXTENSIONS"; do
  _add_to_staging "$ext"
done

cp -a "$PROFILE_STAGING/home/." "$HOME/"
