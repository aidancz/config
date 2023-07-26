#!/bin/sh

path=$(readlink -f "$0")
# absolute path to this script
dir=$(dirname "$path")
# absolute path this script is in

shopt -s dotglob
# loop hidden files

cd $dir/.config
for i in *; do
	rm -rf			"${XDG_CONFIG_HOME:-$HOME/.config}/$i"
	ln -s "$PWD/$i"		"${XDG_CONFIG_HOME:-$HOME/.config}/$i"
done
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/.sh/profile"		"$HOME/.zprofile"
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/.x11/xprofile"	"$HOME/.xprofile"
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/.vim/.vimrc"		"$HOME/.vimrc"

cd $dir/.local/bin
for i in *; do
	rm -rf			"$HOME/.local/bin/$i"
	ln -s "$PWD/$i"		"$HOME/.local/bin/$i"
done

cd $dir/.local/share
for i in $(ls | grep -v "^applications$"); do
	rm -rf			"${XDG_DATA_HOME:-$HOME/.local/share}/$i"
	ln -s "$PWD/$i"		"${XDG_DATA_HOME:-$HOME/.local/share}/$i"
done
# create link except "applications"

cd $dir/.local/share/applications
for i in *; do
	rm -rf			"${XDG_DATA_HOME:-$HOME/.local/share}/applications/$i"
	ln -s "$PWD/$i"		"${XDG_DATA_HOME:-$HOME/.local/share}/applications/$i"
done
