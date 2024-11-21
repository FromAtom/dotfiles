#!/bin/bash

set -u

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

# dotfilesのシンボリックリンク作成
DOT_FILES=( .zsh .zshrc .emacs.d )
for file in ${DOT_FILES[@]}
do
    ln -sf ${THIS_DIR}/$file ${HOME}
done

# link git/config
if [ -r ${THIS_DIR}/git/config ]; then
  [ ! -d ~/.config/git ] && mkdir -pv ~/.config/git
  ln -snf "${THIS_DIR}"/git/config ~/.config/git/config
fi

# link git/ignore
if [ -r ${THIS_DIR}/git/ignore ]; then
  [ ! -d ~/.config/git ] && mkdir -pv ~/.config/git
  ln -snf ${THIS_DIR}/git/ignore ~/.config/git/ignore
fi

# macOS向けの処理
if [ "$(uname)" == 'Darwin' ]; then
    # Homebrew
    if ! which brew > /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew tap Homebrew/bundle
    brew bundle
fi
