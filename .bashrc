# If not running interactively, don't do anything
if [[ -z "$PS1" ]]; then
    alias null='/dev/null'
fi

#source the main bashrc file (I guess..)
source /etc/bash.bashrc

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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
source $HOME/.bashrc.aliases

# enable programmable completion features (so freaking nice!)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


#Path executable options and command variables
PATH="$HOME/bin:$PATH"
export PATH
export GREP_OPTIONS='--color=auto'
export VIMFILES="$HOME/.vim"



##----
## 
## Program-Specific configuration options for various programs that
## deserve their own place in my main bash conf file.  :-)
## 
##----

#Ruby Version Manager (RVM)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

