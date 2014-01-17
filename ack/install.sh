#!/bin/bash

if ! hash ack 2>/dev/null;
then
    if hash curl 2>/dev/null;
    then
        curl http://beyondgrep.com/ack-2.12-single-file -o $HOME/.dotfiles/bin/ack && chmod 0755 $HOME/.dotfiles/bin/ack
    elif hash wget 2>/dev/null;
    then
        wget http://beyondgrep.com/ack-2.12-single-file > ~/bin/ack && chmod 0755 !#:3
    else
        echo "cant install ack. curl or wget is missing"
        exit 1
    fi
fi

exit 0
