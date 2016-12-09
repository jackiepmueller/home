#!/bin/bash
# Copy .vimrc and .bashrc to ~:
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Copying rc files to ~${NC}"
cp .vimrc ~
cp .bashrc ~

# Install tools:
echo -e "${GREEN}Installing tools${NC}"
sudo apt-get install git
sudo apt-get install ack-grep
sudo apt-get install tmux

# Build vim from source to get python support:
echo -e "${GREEN}Installing vim dependencies${NC}"
sudo apt-get remove vim-tiny
sudo apt-get remove vim-common
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby ruby-dev lua5.1 lua5.1-dev libperl-dev git

echo -e "${GREEN}Cloning vim from github${NC}"
cd ~
git clone https://github.com/vim/vim.git

echo -e "${GREEN}Configuring vim build${NC}"
cd vim
./configure \
--with-features=huge \
--enable-multibyte \
--enable-luainterp \
--enable-perlinterp \
--enable-rubyinterp \
--enable-pythoninterp \
--with-python-config-dir=/usr/lib/python2.7/config-x86_65-linux-gnu \
--enable-gui=gtk2 \
--enable-gtk2-check \
--enable-cscope \
--prefix=/usr \
--with-x \
--enable-fail-if-missing


echo -e "${GREEN}Building vim${NC}"
make VIMRUNTIMEDIR=/usr/share/vim/vim80

echo -e "${GREEN}Installing vim${NC}"
sudo make install

echo -e "${GREEN}Updating alternatives${NC}"
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

# Install Vundle:
echo -e "${GREEN}Installing Vundle${NC}"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Setup Vundle:
echo -e "${GREEN}Setting up Vundle${NC}"
vim +PluginInstall +qall

# Finish setting up youcomplete me:
#    Download libclang 3.9:
echo -e "${GREEN}Downloading libclang binaries from llvm.org${NC}"
cd ~
mkdir tmp
cd tmp
wget http://llvm.org/releases/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-debian8.tar.xz
tar xf clang+llvm-3.9.0-x86_64-linux-gnu-debian8.tar.xz

#    Unpack it and install it to usr/local
echo -e "${GREEN}Installing libclang binaries to /usr/local${NC}"
cd clang+llvm-3.9.0-x86_64-linux-gnu-debian8
sudo cp -R * /usr/local

#    Install cmake
echo -e "${GREEN}Installing cmake${NC}"
sudo apt-get install cmake

#    Build the compiled portion:
echo -e "${GREEN}Building compiled portion of YouCompleteMe${NC}"
cd ~
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/local .  ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
