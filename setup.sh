#!/bin/bash

cd ~/home || error "couldn't cd to ~/home"

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0m"

error() {
    echo -e " ${RED}error${NC}  [$1]" >&2
    exit 1
}

found() {
    echo -e " ${GREEN}found${NC}  [$1]"
}

created() {
    echo -e "${YELLOW}created${NC} [$1]"
}

fetched() {
    echo -e "${YELLOW}fetched${NC} [$1]"
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
check_dep git

# Basics
make_sym .bashrc
make_sym .tmux.conf
make_sym .vimrc
make_sym .inputrc
make_sym .psqlrc

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
        git clone https://github.com/junegunn/vim-plug.git ~/home/vim-plug || error "cloning vim-plug"
        fetched "vim-plug"
    else
        found "vim-plug"
    fi

    make_dir .vim/autoload

    make_sym plug.vim .vim/autoload vim-plug
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
