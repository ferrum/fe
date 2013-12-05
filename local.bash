#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" = "activate" ]
then    
    $SHELL --init-file $DIR/$0 -i
    exit 0
fi

. ~/.bashrc

export PROMPT_DIRTRIM=2
export GOPATH=$DIR/workspace
export PATH=$DIR/workspace/bin/:$PATH
export PROJECT="fe"
plum="\[\033[38;5;54m\]"
reset="\[\033[00m\]"
export PS1="[${plum}fe${reset}] $PS1"
cd workspace/src/github.com/ferrum/fe
