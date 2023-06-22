## Pre-Installation
### OSX
1. Download and install [iTerm](https://www.iterm2.com/)
2. Set ALT to meta key: `iterm2 > Preferences > Profiles > Default > Keys > Left ⌥ Key: Esc+`
3. Install [OneDark](https://github.com/joshdick/onedark.vim) iTerm colors
4. Install [Homebrew](https://brew.sh/)
5. Install bash via homebrew: `brew install bash`
6. Set your default shell to brew's bash:
```bash
sudo vi /etc/shells
# Add the following line to the end of the file:
/usr/local/bin/bash
# write & quit
chsh -s /usr/local/bin/bash $USER
```
7. Restart iterm2
8. Install coreutils: `brew install coreutils`
9. Once installed, the profile will help us manage our path, but for now we need to manually add coreutils bin to our path for use by the profile installer.
```bash
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
```

### WSL
#### Install Windows Terminal
_Note: Windows Terminal comes installed by default on newer versions of windows. Skip this step if you already have it_
1. go to https://github.com/microsoft/terminal/releases and pick a release to install
2. Open the settings json file and replace with the contents of `scripts/windows-terminal-setttings.json`
3. Open the Actions settings menu
  a. Remove the CTRL+C copy action
  b. Remove the CTRL+V paste action

#### Install WSL
1. Open powershell and run `wsl --install`
  a. If you encounter an error with the windows store run `wsl --install Ubuntu --web-download`
  b. If the install freezes at 0 percent, restart your computer and retry

## Installation (All Platforms)
1. clone the profile:
```bash
git clone https://github.com/ischaaf/profile.git ~/.profile.d
```
2. `cd ~/.profile.d`
3. `bash install.sh`
4. Start a new terminal session to re-source all profile files
5. install neovim plugins
```
nvim
:PlugInstall
:UpdateRemotePlugins
```

## Post Install
#### [Optional] Remove fzf shell history override
1. Open `~/.fzf/shell/key-bindings.bash`
2. comment out the following lines:
```
  bind -m emacs-standard -x '"\C-r": __fzf_history__'
  bind -m vi-command -x '"\C-r": __fzf_history__'
  bind -m vi-insert -x '"\C-r": __fzf_history__'
```

#### Setup neovim windows clipboard
1. Download [Win32Yank](https://github.com/equalsraf/win32yank/releases/tag/v0.1.1)
2. Extract the zip and move the binary into `C:\Users\<name>\bin\`
3. Link the binary to your home bin dir
```
ln -s /mnt/c/Users/ischaaf/bin/win32yank.exe ~/bin/win32yank.exe
```

## Issues
Issue: sourcing profile results in `command have not found`
