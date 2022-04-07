#!/usr/bin/zsh

if [[ ! -h $HOME/.zshrc ]]
then
	rm ~/.zshrc
	ln -s $AIDAN_CONFIG/zsh/zshrc ~/.zshrc
fi

if [[ ! -h $HOME/.zimrc ]]
then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	#https://github.com/zimfw/zimfw
	rm ~/.zimrc
	ln -s $AIDAN_CONFIG/zsh/zimrc ~/.zimrc
fi

if [[ ! -h $HOME/.config/nvim ]]
then
	rm ~/.config/nvim
	ln -s $AIDAN/FD/nvim ~/.config/nvim
fi

if [[ ! -h $HOME/.config/ranger ]]
then
	rm ~/.config/nvim
	ln -s $AIDAN/FD/ranger ~/.config/ranger
fi
