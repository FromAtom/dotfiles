# dotfiles

```sh
# Clone with submodules
$ git clone --recursive git@github.com:FromAtom/dotfiles.git

# Or if already cloned
$ git submodule update --init --recursive

$ ./setup.sh
```
# for Mac

## Dockの全てのアイコンを削除する
```sh
defaults write com.apple.dock persistent-apps -array
killall Dock
```