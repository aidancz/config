#!/bin/sh
# lsl: local symbolic link

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ xdg
XDG_EXE_HOME="$HOME/.local/bin"
XDG_CONFIG_HOME="$HOME/.local/etc"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.local/var/cache"
XDG_STATE_HOME="$HOME/.local/var/log"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $path & $dir
path=$(readlink -f "$0")
# absolute path to this script
dir=$(dirname "$path")
# absolute path this script is in

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ shopt
shopt -s dotglob
# loop hidden files

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG_EXE_HOME
mkdir -p "$XDG_EXE_HOME"
cd $dir/bin
for i in *; do
	rm -rf					"$XDG_EXE_HOME/$i"
	ln -s "$PWD/$i"			"$XDG_EXE_HOME/$i"
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG_CONFIG_HOME
mkdir -p "$XDG_CONFIG_HOME"
cd $dir/etc
for i in *; do
	rm -rf					"$XDG_CONFIG_HOME/$i"
	ln -s "$PWD/$i"			"$XDG_CONFIG_HOME/$i"
done

ln -sf "$XDG_CONFIG_HOME/sh/profile"		"$HOME/.profile"
ln -sf "$XDG_CONFIG_HOME/sh/profile"		"$HOME/.zprofile"
ln -sf "$XDG_CONFIG_HOME/bash/.bashrc"		"$HOME/.bashrc"
ln -sf "$XDG_CONFIG_HOME/x11/.xprofile"		"$HOME/.xprofile"
ln -sf "$XDG_CONFIG_HOME/vim/.vimrc"		"$HOME/.vimrc"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG_DATA_HOME
mkdir -p "$XDG_DATA_HOME"
cd $dir/share
for i in *; do
	rm -rf					"$XDG_DATA_HOME/$i"
	ln -s "$PWD/$i"			"$XDG_DATA_HOME/$i"
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG_CACHE_HOME
mkdir -p "$XDG_CACHE_HOME"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG_STATE_HOME
mkdir -p "$XDG_STATE_HOME"
