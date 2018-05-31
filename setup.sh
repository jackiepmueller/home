#!/bin/bash
ln -s ~/home/.bashrc    ~
ln -s ~/home/.tmux.conf ~
ln -s ~/home/.vimrc     ~
ln -s ~/home/.vim       ~

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
