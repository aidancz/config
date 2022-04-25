#!/bin/bash

export AIDAN=$HOME/Aidan
export AIDAN_FD=$AIDAN/FD

rm -rf ~/.zshrc
ln -s $AIDAN_FD/config/zsh/zshrc ~/.zshrc

rm -rf ~/.zimrc
ln -s $AIDAN_FD/config/zsh/zimrc ~/.zimrc

rm -rf ~/.config/nvim
ln -s $AIDAN_FD/config/nvim ~/.config/nvim

rm -rf ~/.config/ranger
ln -s $AIDAN_FD/config/ranger ~/.config/ranger
