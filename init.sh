#!/bin/bash

export a_gi=/home/ai/a_gi

rm -rf ~/.zshrc
ln -s $a_gi/config/zsh/zshrc ~/.zshrc

rm -rf ~/.zimrc
ln -s $a_gi/config/zsh/zimrc ~/.zimrc

rm -rf ~/.config/nvim
ln -s $a_gi/config/nvim ~/.config/nvim

rm -rf ~/.config/ranger
ln -s $a_gi/config/ranger ~/.config/ranger
