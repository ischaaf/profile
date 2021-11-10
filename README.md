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
1. go to https://github.com/microsoft/terminal/releases and pick a release to install
2. Open the settings json file and replace with the contents of `scripts/windows-terminal-setttings.json`

#### Install Ubuntu
1. Go do https://cloud-images.ubuntu.com/releases/ and select a version to install
2. look for a file named like https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64-wsl.rootfs.tar.gz and download it
3. run `wsl.exe --import Ubuntu <Install Folder> <.TAR.GZ File Path>`
  * Distribution Name: A friendly name. eg Ubuntu
  * Install folder: a place to put the virtual hard disk, this will not contain human readable files
4. Start the distro and run the following
```bash
NEW_USER=ischaaf
adduser "${NEW_USER}"
adduser "${NEW_USER}" sudo
tee /etc/wsl.conf <<_EOF
[user]
default=${NEW_USER}
_EOF
```
5. **Care: this will exit all distros**. Exit the session, then fully shutdown the distro using `wsl --shutdown Ubuntu`

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
