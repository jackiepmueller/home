#!/bin/bash

# vim configuration line:
# ./configure --with-features=huge --enable-python3interp=yes --enable-pythoninterp=yes --with-python3-config-dir=<the right place> --enable-fail-if-missing

error() {
    echo " error: $1" >&2
    exit 1
}

found() {
    echo " found  [$1]"
}

created() {
    echo "created [$1]"
}

fetched() {
    echo "fetched [$1]"
}

check_dep() {
    if ! [ -x "$(command -v $1)" ]; then
        error "$1 is not installed"
    else
        found $1
    fi
}

# create a symlink from a file in ~/home to ~
#
# arg 1: file in ~/home
# arg 2: optional "to" path relative to ~ 
# arg 3: optional "from" path relative to ~/home
make_sym() {
    from=~/home/$1
    to=~/$1

    [ $# -ge 3 ] && from=~/home/$3/$1

    [ -e $from ] || error "making symlink $to -> $from, $from doesn't exist"

    [ $# -ge 2 ] && to=~/$2/$1

    [ -e $to ] && [ ! -h $to ] && error "making symlink $to -> $from, $to exists and is not a symlink"

    if [ ! -e $to ]; then
        ln -s $from $to || error "making symlink $to -> $from"
        created "$to -> $from"
    else
        found "$to -> $from"
    fi
}

make_dir() {
    dirname=~/$1
    if [ ! -d $dirname ]; then
        mkdir -p $dirname
        created $dirname
    else
        found $dirname
    fi
}

check_dep vim
check_dep tmux
check_dep curl
check_dep git

# Basics
make_sym .bashrc
make_sym .tmux.conf
make_sym .vimrc
make_sym .inputrc


# Add keyboard remappings for chromebook
[ "$HOSTNAME" = "gal" ] && make_sym .xkb

make_dir .bashrc.d

# Debian/Ubuntu specific stuff
[ -f "/etc/debian_version" ] && make_sym deb.bash .bashrc.d

# Setup nvim
make_dir .config/nvim
make_sym init.vim .config/nvim

# Create swap files dir
make_dir .vim/swapfiles

# Setup vim colorscheme
make_dir .vim/colors
make_sym mevening.vim .vim/colors

# Vim Plug
plug=~/.vim/autoload/plug.vim
if [ ! -e $plug ]; then
    if [ ! -d vim-plug ]; then
        git clone https://github.com/junegunn/vim-plug.git || error "cloning vim-plug"
        fetched "vim-plug"
    fi

    #ln -s $from $plug || error "making symlink $plug -> $from"
    make_sym plug.vim .vim/autoload vim-plug
    #created "$from -> $plug"
else
    found $plug
fi

# TPM
tpm=~/.tmux/plugins/tpm
if [ ! -d $tpm ]; then
    mkdir -p $tpm
    git clone https://github.com/tmux-plugins/tpm $tpm || error "cloning tpm"
    fetched $tpm
else
    found $tpm
fi
