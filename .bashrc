#!/bin/bash

# If not running interactively, don't do anything
if [[ -z "$PS1" ]] ; then 
  alias null='/dev/null' 
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Assume that we have color support (why wouldn't we) and make a pretty prompt
# The prompt reads user@host:dir$
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
# Ensure that the prompt starts at the far-left side (remove ^C crap and what not)
# From: http://jonisalonen.com/2012/your-bash-prompt-needs-this/
PS1="\[\033[G\]$PS1"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Path executable options and command variables
PATH="$HOME/bin:$PATH"
export PATH
export GREP_OPTIONS='--color=auto'
export VIMFILES="$HOME/.vim"
export EDITOR='vim'

# Load rbenv if available
if [ -e "$HOME/.rbenv/bin" ] && [ -d "$HOME/.rbenv/bin" ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Specify GoLang settings
export GOPATH="$HOME/.go";
export PATH="${GOPATH//://bin:}/bin:$PATH";





##
## Load External Files
##


# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions
if [ -e $HOME/.bashrc.aliases ] && [ -f $HOME/.bashrc.aliases ] ; then
  source $HOME/.bashrc.aliases
fi

# Load .bash_etc if it is available (for OS-specific configs, not versioned)
# also, we want to load this last so that it can be used for any overrides
if [ -e "$HOME/.bash_etc" ] ; then
  . "$HOME/.bash_etc"
fi
