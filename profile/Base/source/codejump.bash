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

function _get_c_paths() {
    declare -a names
    local name
    local prefix="${1:-}"
    for match in $DEVELOPER_ROOT/**/**/*; do
        name="$(echo "$match" | sed "s|^$DEVELOPER_ROOT/||" | awk 'BEGIN { FS = "/" } ; {print $3 "__" $2 "__" $1 }')"
        if [[ $name == $prefix* ]]; then
            echo "$match"
            return
        fi
    done
}

function c() {
    if [[ -z "${1:-}" ]]; then
        echo "Usage c git_url|dirname" >&2
        return 1
    fi
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
    local resp="$(_get_c_paths "$repo")"
    if [[ -n $resp ]]; then
        cd "$resp"
        return
    fi
    echo "No Matches"
    return 1
    # local matches=($DEVELOPER_ROOT/**/**/*$repo*)

    # if [[ ${#matches[@]} == 1 && ${matches[0]} != "$DEVELOPER_ROOT/"'**/**/*'"$repo"'*' ]]; then
    #     cd ${matches[0]}
    #     return
    # fi

    # if [[ ${#matches[@]} == 1 ]]; then
    #     echo "No matches for $repo" >&2
    #     return 1
    # fi
    # echo "Multiple matches for $repo, ${#matches[@]}" >&2
    # for match in "${matches[@]}"; do
    #     echo "  ${match}"
    # done
}

function _c_completions () {
    declare -a names
    names=($(compgen -W "$(echo $DEVELOPER_ROOT/**/**/* | sed "s|$DEVELOPER_ROOT/||g" | sed 's/ /\n/g' | awk 'BEGIN { FS = "/" } ; {print $3 "__" $2 "__" $1 }')" -- "${COMP_WORDS[1]}"))
    # local name
    # local prefix="${1:-}"
    # for match in $DEVELOPER_ROOT/**/**/*; do
    #     names+=("$(echo "$match" | sed "s|^$DEVELOPER_ROOT/||" | awk 'BEGIN { FS = "/" } ; {print $3 "__" $2 "__" $1 }')")
    # done
    COMPREPLY=(${names[@]})
}

complete -F _c_completions c
