#!/bin/bash

# vim configuration line:
# ./configure --with-features=huge --enable-python3interp=yes --enable-pythoninterp=yes --with-python3-config-dir=<the right place> --enable-fail-if-missing

check_dep() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "error $1 is not installed" >&2
        exit 1
    else
        echo "found $1"
    fi
}

# create a symlink from a file in ~/home to ~
#
# arg 1: a file in ~/home
# arg 2: an optional path relative to ~
make_sym_link() {
    from=~/home/$1
    to=~/$1
    if [ $# == 2 ]; then
        to=~/$2/$1
    fi

    if [ ! -e $to ]; then
        ln -s $from $to 
        echo "created [$to -> $from]"
    else
        echo " found  [$to -> $from]"
    fi
}

check_dep vim
check_dep tmux
check_dep curl
check_dep git

# Basics
make_sym_link .bashrc
make_sym_link .tmux.conf
make_sym_link .vimrc
make_sym_link .inputrc


# Add keyboard remappings for chromebook
[ "$HOSTNAME" = "gal" ] && make_sym_link .xkb

[ ! -d ~/.bashrc.d ] && mkdir -p ~/.bashrc.d

# Debian/Ubuntu specific stuff
[ -f "/etc/debian_version" ] && make_sym_link deb.bash .bashrc.d

# Create nvim config dir
[ ! -d ~/.config/nvim ] && mkdir -p ~/.config/nvim

make_sym_link init.vim .config/nvim

# Create swap files dir
[ ! -d ~/.vim/swapfiles ] && mkdir -p ~/.vim/swapfiles

# Create colors dir
[ ! -d ~/.vim/colors ] && mkdir -p ~/.vim/colors

make_sym_link mevening.vim .vim/colors

# Vim Plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# TPM
[ ! -d ~/.tmux/plugins/tpm ] && mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
