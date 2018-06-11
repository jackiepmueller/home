#!/bin/bash

check_dep() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error $1 is not installed." >&2
        exit 1
    fi
}

check_dep curl
check_dep git

ln -s ~/home/.bashrc    ~
ln -s ~/home/.tmux.conf ~
ln -s ~/home/.vimrc     ~
ln -s ~/home/.vim       ~

if [ ! -d ~/.vim/swapfiles ]; then
    mkdir ~/home/.vim/swapfiles
fi

# Vim Plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# TPM
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
