export WINDOWS_LOGNAME
WINDOWS_LOGNAME="$(cmd.exe /c "echo %USERNAME%" | tr -d '[:space:]')"
_add_path "/mnt/c/Users/$WINDOWS_LOGNAME/wsl_bin"
