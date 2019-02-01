export DISPLAY=:0.0
export MANPATH="/usr/local/man:$MANPATH"
export MAGICK_FONT_PATH="/Library/Fonts"

alias ls='ls -GFa'
alias o='open'
alias new='openterminal.sh'

if [ -e ~/.MacOSX/environment.plist ]; then
  export PATH
  PATH="$(grep -A1 PATH ~/.MacOSX/environment.plist | \
    grep "<string>" | cut -d'>' -f2 | cut -d'<' -f1)"
fi

prompt_color() {
  echo "${COLOR_GREEN}"
}

# Emits the current time in 24-hr notation.
show_time() {
  echo "${COLOR_WHITE}$(date +%H:%M)${COLOR_NONE}"
}
