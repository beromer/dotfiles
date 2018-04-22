#! /bin/bash

rm -f ~/.vimrc
rm -f ~/.bash_common

mkdir ~/.tmp

ln -s "$(realpath .vimrc)" ~/.vimrc
ln -s "$(realpath .bash_common)"  ~/.bash_common
echo "source ~/.bash_common" >> ~/.bashrc
