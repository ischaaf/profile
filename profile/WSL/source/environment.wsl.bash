export WINDOWS_LOGNAME
WINDOWS_LOGNAME="$(cd /mnt/c && cmd.exe /c "echo %USERNAME%" | tr -d '[:space:]')"
_add_path "/mnt/c/Users/$WINDOWS_LOGNAME/wsl_bin"

if [[ -z "${SSH_AGENT_PID:-}" ]]; then
    echo "Setting up ssh agent"
    eval "$(ssh-agent)"
    export SSH_AGENT_PID
    for f in "$HOME/.ssh/"*.pub; do
        ssh-add "${f%.pub}"
    done
else
    echo "SSH agent found at pid: $SSH_AGENT_PID"
fi
