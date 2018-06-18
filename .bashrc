# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#set -g default-terminal "screen-256color"
export TERM=screen-256color
export DIFF=/usr/bin/vimdiff

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Disable ctrl-s and ctrl-q
stty -ixon

# Set prompt to username&hostname:PWD$
PS1='\u@\h:\w\$ '

# some more aliases
alias pyclean='find . -name *.pyc | xargs rm -v'
alias vis='vim --servername VIM-`hostname`'
alias vir='vim --servername VIM-`hostname` --remote'
alias gdd='git difftool -d'
alias gs='git status'
alias gl='git log'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=vim
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Shows who committed the most in the past 2 years
function whoowns {                                                                                                                                                                                                                                                               
    git log --pretty=format:"%an" --after="2 years" ${@} | sort | uniq -c | sort -r                                                                                                                                                                                              
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Keep work related stuff in a separate rc file
#if [ -f ~/.work.bashrc ]; then
#    . ~/.work.bashrc
#fi
[ -f ~/.work.bashrc ] && source ~/.work.bashrc

# Make it easy to append your own customizations that override the above by
# loading all files from .bashrc.d directory
mkdir -p ~/.bashrc.d
if [ -n "$(ls ~/.bashrc.d)" ]; then
  for dotfile in ~/.bashrc.d/*
  do
    if [ -r "${dotfile}" ]; then
      source "${dotfile}"
    fi
  done
fi
