#!/bin/bash

# vim configuration line:
# ./configure --with-features=huge --enable-python3interp=yes --enable-pythoninterp=yes --with-python3-config-dir=<the right place> --enable-fail-if-missing

check_dep() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error $1 is not installed." >&2
        exit 1
    fi
}

check_dep curl
check_dep git

# Basics
ln -s ~/home/.bashrc    ~
ln -s ~/home/.tmux.conf ~
ln -s ~/home/.vimrc     ~
ln -s ~/home/.vim       ~

# Add keyboard remappings for chromebook
[ "$HOSTNAME" = "gal" ] && ln -s ~/home/.xkb ~

mkdir -p ~/.bashrc.d

# Debian/Ubuntu specific stuff
[ -f "/etc/debian_version" ] && ln -s ~/home/deb.bash ~/.bashrc.d/deb.bash

# Create swap files dir
[ ! -d ~/.vim/swapfiles ] && mkdir ~/home/.vim/swapfiles

# Vim Plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# TPM
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
