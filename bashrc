if [ -f ~/.bashrc.before ]; then
  . ~/.bashrc.before
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# bash history
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100
HISTFILESIZE=200
shopt -s histappend

shopt -s checkwinsize   # check window size after each command
shopt -s dotglob        # make asterisk (*) match hidden files too

# bash colors
export TERM=screen-256color # works best with vim/tmux in 256 colors mode

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# aliases
if [ -f ~/.bash/bash_aliases ]; then
  . ~/.bash/bash_aliases
fi

# functions
if [ -f ~/.bash/bash_functions ]; then
  . ~/.bash/bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

export EDITOR=vim
export SHELL=/bin/bash

# CLI look
source ~/.bash/bin/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export PS1="\[\e[1;30m\]\w\[\e[m \]\$($(cat ~/.bash/bin/git-ps1/git-ps1.sh))"

PATH="$HOME/.bash/bin:$PATH"

bind '"\C-i": menu-complete'

if [ -f ~/.bashrc.after ]; then
  . ~/.bashrc.after
fi
