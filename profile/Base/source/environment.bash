#!/usr/bin/env bash

[ -n "$PS1" ] && bind "set completion-ignore-case on" >/dev/null 2>&1

# Returns 0 (success) if the pwd is tracked, otherwise 1 (failure).
git_pwd_is_tracked() {
   [ $(git log -1 --pretty=oneline . 2> /dev/null | wc -l) -eq "1" ]
}

# Emits the current time in 24-hr notation.
show_time() {
  echo "${COLOR_GRAY}$(date +%H:%M)${COLOR_NONE}"
}

# Stores the exit status of the last command for use by show_exit_status function.
if [[ ! $PROMPT_COMMAND =~ store_exit_status ]]; then
  export PROMPT_COMMAND="store_exit_status && ${PROMPT_COMMAND:-:}"
fi
store_exit_status() {
  LAST_EXIT_STATUS=$?
}

# Emits exit status of last command if error condition returned.
show_exit_status() {
  if [ "x${LAST_EXIT_STATUS}" != "x0" ]; then
    echo " [${COLOR_RED}${LAST_EXIT_STATUS}${COLOR_NONE}]"
  fi
}

# Emits the current git branch and marker if there are outstanding changes.
show_git_branch_and_status() {
  if git_pwd_is_tracked; then
    local branch_prompt
    branch_prompt=$(__git_ps1 " (${COLOR_YELLOW}%s${COLOR_NONE})")
    if [[ -n "$branch_prompt" ]]; then
      echo "$branch_prompt $(show_git_status)"
    fi
  fi
}

# Removes display of git status from prompt, useful for large repositories.
hide_git_status() {
  show_git_branch_and_status() { exit; }
}

# Emits a red ✗ if current repository is 'dirty'.
show_git_status() {
  STATUS="$(git status 2> /dev/null | tail -n1)"
  # NB: as of git version 1.8.1.2, the output for a clean git commit has changed
  if [ "$STATUS" == "nothing to commit, working tree clean" ]; then
    return 0
  fi

  if [ "$STATUS" == "nothing to commit, working directory clean" ]; then
    return 0
  fi

  echo "${COLOR_RED}変${COLOR_NONE}"
}

export PS1='$(show_time) $(prompt_color)'"\u@\h${COLOR_NONE}: ${COLOR_CYAN}\w${COLOR_NONE}"'$(show_exit_status)$(show_git_branch_and_status)'"\n> "

function profile_min_prompt () {
    export PS1='$(show_time) $(prompt_color)'"\u@\h${COLOR_NONE}: ${COLOR_CYAN}\w${COLOR_NONE}"'$(show_exit_status)'"\n> "
}

function profile_default_prompt () {
    export PS1='$(show_time) $(prompt_color)'"\u@\h${COLOR_NONE}: ${COLOR_CYAN}\w${COLOR_NONE}"'$(show_exit_status)$(show_git_branch_and_status)'"\n> "
}

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

shopt -s histappend
