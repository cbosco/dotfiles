#!/usr/bin/env bash

source ~/.bash/aliases
source ~/.bash/paths
source ~/.bash/config

export EDITOR=`which vim`
export PYTHONSTARTUP=$HOME/.pystartup
export NODE_PATH=/usr/local/lib/node_modules

export CLICOLOR=1

if [ -f ~/.localrc ]; then
  . ~/.localrc
fi
