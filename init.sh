#!/bin/bash

export AIDAN=$HOME/Aidan
export AIDAN_CONFIG=$AIDAN/FD/config

if [[ ! -d $HOME/.zim ]]
then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	#https://github.com/zimfw/zimfw
fi

rm -rf ~/.zshrc
ln -s $AIDAN_CONFIG/zsh/zshrc ~/.zshrc

rm -rf ~/.zimrc
ln -s $AIDAN_CONFIG/zsh/zimrc ~/.zimrc

rm -rf ~/.config/nvim
ln -s $AIDAN_CONFIG/nvim ~/.config/nvim

rm -rf ~/.config/ranger
ln -s $AIDAN_CONFIG/ranger ~/.config/ranger
