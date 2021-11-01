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

"$PROFILE_ROOT/install.sh" $EXTENSIONS
