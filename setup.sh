#!/bin/bash

THIS_DIR=home

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
LIGHTBLUE="\033[0;94m"
RED="\033[0;31m"
PURPLE="\033[0;35m"
NC="\033[0m"

error() {
    echo -e " ${RED}error${NC}  [$1]" >&2
    exit 1
}

post() {
    echo -e " ${PURPLE}post${NC}  [$1]" >&2
    exit 1
}

found() {
    echo -e " ${GREEN}found${NC}  [$1]"
}

created() {
    echo -e "${LIGHTBLUE}created${NC} [$1]"
}

copied() {
    echo -e "${LIGHTBLUE}copied${NC} [$1]"
}

fetched() {
    echo -e "${LIGHTBLUE}fetched${NC} [$1]"
}

check_dep() {
    if ! [ -x "$(command -v $1)" ]; then
        error "$1 is not installed"
    else
        found $1
    fi
}

check_post() {
    if ! [ -x "$(command -v $1)" ]; then
        post "$1 is not installed"
    else
        found $1
    fi
}

# create a symlink from a file in ~/$THIS_DIR to ~
#
# arg 1: file in ~/$THIS_DIR
# arg 2: optional if destination name or path should differ
make_sym() {
    from=~/$THIS_DIR/$1
    to=~/$1

    [ $# -ge 2 ] && to=~/$2

    [ -e $from ] || error "making symlink $to -> $from, $from doesn't exist"
    [ -e $to ] && [ ! -h $to ] && error "making symlink $to -> $from, $to exists and is not a symlink"

    if [ ! -e $to ]; then
        ln -s $from $to || error "making symlink $to -> $from"
        created "$to -> $from"
    else
        found "$to -> $from"
    fi
}

# copy file in ~/THIS_DIR to ~
#
# arg 1: file in ~/THIS_DIR
# arg 2: optional name for file in ~
make_copy() {
    from=~/$THIS_DIR/$1
    to=~/$1

    [ $# -ge 2 ] && to=~/$2

    if [ ! -e $to ]; then
        cp $from $to
        copied "$from to $to"
    else
        found "$to"
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

cd ~/$THIS_DIR || error "couldn't cd to ~/$THIS_DIR"

check_dep nvim
check_dep xsel  # system clip board support
check_dep tmux
check_dep git

# Basics
make_sym .bash_profile
make_sym .bashrc
make_sym .tmux.conf
make_sym .vimrc
make_sym .inputrc
make_sym .psqlrc
make_sym .gdbinit

make_dir .bashrc.d

# Debian/Ubuntu specific stuff
[ -f "/etc/debian_version" ] && make_sym deb.bash .bashrc.d/deb.bash

# Setup nvim
make_dir .config/nvim
make_dir .config/nvim/plugin
make_sym init.vim .config/nvim/init.vim
make_sym coc-settings.json .config/nvim/coc-settings.json

# Create swap files dir
make_dir .vim/swapfiles

# Setup vim colorscheme
make_dir .config/nvim/colors
make_sym mevening.vim .config/nvim/colors/mevening.vim

# Setup vim syntax
make_dir .vim/syntax
make_sym c.vim .vim/syntax/c.vim

# Setup non-plug plugins
make_sym a.vim .config/nvim/plugin/a.vim

# Setup ssh config
make_dir .ssh
make_sym ssh-config .ssh/config

make_copy .gitconfig

# Vim Plug
plug=~/.local/share/nvim/site/autoload/plug.vim
if [ ! -e $plug ]; then
    if [ ! -d vim-plug ]; then
        git clone https://github.com/junegunn/vim-plug.git ~/$THIS_DIR/vim-plug || error "cloning vim-plug"
        fetched "vim-plug"
    else
        found "vim-plug"
    fi

    make_dir .local/share/nvim/site/autoload

    make_sym vim-plug/plug.vim .local/share/nvim/site/autoload/plug.vim
else
    found $plug
fi

check_dep clangd

# TPM
tpm=~/.tmux/plugins/tpm
if [ ! -d $tpm ]; then
    mkdir -p $tpm
    git clone https://github.com/tmux-plugins/tpm $tpm || error "cloning tpm"
    fetched $tpm
else
    found $tpm
fi

# Manual Installs
check_post fzf
check_post rg
check_post node
