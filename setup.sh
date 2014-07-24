#!/bin/bash

DOT_FILES=( .zsh .zshrc .emacs.d .gitconfig .gitignore )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/projects/dotfiles/$file $HOME/$file
done
