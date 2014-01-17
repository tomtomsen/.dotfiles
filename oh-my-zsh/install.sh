#!/bin/bash

echo ''

if ! hash zsh 2>/dev/null;
then
    # zsh is not installed

    platform=$(uname);
    if [[ $platform == 'Linux' ]]
    then
        sudo apt-get install zsh
        install_zsh
    else
        echo "Please install zsh"
        exit 1
    fi
fi

if hash zsh 2>/dev/null;
then
    # zsh is installed

    if [ -d "$HOME/.oh-my-zsh" ]
    then
        echo "oh-my-zsh is already installed"
        exit 0
    elif hash curl 2>/dev/null;
    then
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    elif hash wget 2>/dev/null;
    then
        wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
    elif hash git 2>/dev/null;
    then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        if [ -f ~/.zshrc ] 
        then
            cp ~/.zshrc ~/.zshrc.backup
        fi

        chsh -s /bin/zsh
    else
        echo "to install zsh please install curl, wget or git"
    fi
fi
