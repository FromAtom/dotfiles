#!/bin/bash

set -u

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

# dotfilesのシンボリックリンク作成
DOT_FILES=( .zsh .zshrc .emacs.d .gitconfig .gitignore )
for file in ${DOT_FILES[@]}
do
    ln -s ${THIS_DIR}/$file ${HOME}
done

# macOS向けの処理
if [ "$(uname)" == 'Darwin' ]; then
    # Homebrew
    if ! which brew > /dev/null; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew tap Homebrew/bundle
    brew bundle
fi
