#!/bin/bash

rm -rf vim.symlink

if hash git 2>/dev/null;
then
#    git clone https://github.com/tomasr/molokai.git vim.symlink
# else
    mkdir -p ./vim.symlink/colors
    wget -O vim.symlink/colors/molokai.vim https://raw2.github.com/tomasr/molokai/master/colors/molokai.vim
fi
