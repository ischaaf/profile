#!/usr/bin/env bash

set -eu -o pipefail

# set option to correctly handle glob if no files match the glob expression
shopt -s nullglob

PROFILE_ROOT="$HOME/.profile.d"
PROFILE_STAGING="$PROFILE_ROOT/staging"

if [[ -f "$PROFILE_STAGING/extensions.txt" ]]; then
  EXTENSIONS="$(cat "$PROFILE_STAGING/extensions.txt")"
else
  EXTENSIONS=""
fi

for f in $PROFILE_STAGING/source/*; do
    unlink "$f"
done

for f in $PROFILE_STAGING/install/*; do
    unlink "$f"
done

for f in $(find "$PROFILE_STAGING/home/"); do
    if [[ -L "$f" ]]; then
        relpath="${f//$PROFILE_STAGING\/home\//}"
        fdir="$(dirname "$HOME/$relpath")"
        unlink "$HOME/$relpath" || :
        if [[ "$fdir" != "$HOME" ]]; then
            rmdir "$fdir" || :
        fi
    fi
done
rm -rf "$PROFILE_STAGING/home"
mkdir "$PROFILE_STAGING/home"

"$PROFILE_ROOT/install.sh" $EXTENSIONS
