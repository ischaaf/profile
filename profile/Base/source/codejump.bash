#!/usr/bin/env bash

export DEVELOPER_ROOT="$HOME/code"
GIT_RE="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git"

function _reformat_git_url () {
  local url="$1"
  local output_fmt="$2"
  if [[ $url =~ $GIT_RE ]]; then
    echo "$output_fmt" | sed \
        -e "s/protocol/${BASH_REMATCH[1]}/" \
        -e "s/separator/${BASH_REMATCH[2]}/" \
        -e "s/hostname/${BASH_REMATCH[3]}/" \
        -e "s/user/${BASH_REMATCH[4]}/" \
        -e "s/repo/${BASH_REMATCH[5]}/"
  else
    echo "URL not a git url" >&2
    return 1
  fi
}

function c() {
    local rel_repo_path full_repo_path
    rel_repo_path="$(_reformat_git_url "${1-}" "hostname/user/repo" 2>/dev/null)"
    if [[ "$?" == 0 ]]; then
        # we were passed a git url, lets check if it exists
        full_repo_path="$DEVELOPER_ROOT/$rel_repo_path"
        if [[ -d "$full_repo_path" ]]; then
            cd "$full_repo_path"
            return
        fi
        mkdir -p "$full_repo_path"
        git clone "$1" "$full_repo_path"
        cd "$full_repo_path"
        return
    fi
    # not a git url, lets see if it's a local path
    local repo="$1"
    local matches=($DEVELOPER_ROOT/**/**/*$repo*)

    if [[ ${#matches[@]} == 1 && ${matches[0]} != "$DEVELOPER_ROOT/"'*/*'"/$repo" ]]; then
        cd ${matches[0]}
        return
    fi

    if [[ ${#matches[@]} == 1 ]]; then
        echo "No matches for $repo, ${#matches[@]}" >&2
        return 1
    fi
    echo "Multiple matches for $repo, ${#matches[@]}" >&2
    for match in "${matches[@]}"; do
        echo "  ${match}"
    done
}
