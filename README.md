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
## Installation (All Platforms)
1. clone the profile:
```bash
git clone https://github.com/ischaaf/profile.git ~/.profile.d
```
2. `cd ~/.profile.d`
3. `bash install.sh`
4. `source ~/.profile`
5. install neovim plugins
```
nvim
:PlugInstall
:UpdateRemotePlugins
```

## Issues
Issue: sourcing profile results in `command have not found`
Fix:
