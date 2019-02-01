if ! command -v brew; then
  return
fi

BASH_COMPLETION_PATH="$(brew --prefix)/etc/profile.d/bash_completion.sh"
BAKE_COMPLETION_PATH="$(brew --prefix)/opt/bake/bin/bake-completion.sh"

# shellcheck disable=SC1090
[[ -r "$BASH_COMPLETION_PATH" ]] && . "$BASH_COMPLETION_PATH"
# shellcheck disable=SC1090
[[ -r "$BAKE_COMPLETION_PATH" ]] && . "$BAKE_COMPLETION_PATH"
