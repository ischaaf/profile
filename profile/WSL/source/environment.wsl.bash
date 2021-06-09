export WINDOWS_LOGNAME
WINDOWS_LOGNAME="$(cd /mnt/c && cmd.exe /c "echo %USERNAME%" | tr -d '[:space:]')"
_add_path "/mnt/c/Users/$WINDOWS_LOGNAME/wsl_bin"
