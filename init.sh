#!/bin/bash

export a=$HOME/a
export a_sr=$HOME/a_sr

rm -rf ~/.zshrc
ln -s $a_sr/config/zsh/zshrc ~/.zshrc

rm -rf ~/.zimrc
ln -s $a_sr/config/zsh/zimrc ~/.zimrc

rm -rf ~/.config/nvim
ln -s $a_sr/config/nvim ~/.config/nvim

rm -rf ~/.config/ranger
ln -s $a_sr/config/ranger ~/.config/ranger
