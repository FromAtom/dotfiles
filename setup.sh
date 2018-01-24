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
