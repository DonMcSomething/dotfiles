#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(thefuck --alias)"
alias config='/usr/bin/git --git-dir=/home/don/.cfg/ --work-tree=/home/don'
