#!/bin/sh

mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

cd .config

ln -sf "$PWD"/shell/profile "$HOME/.zprofile"
ln -sf "$PWD"/x11/xprofile "$HOME/.xprofile"

for i in *; do
	rm -rf			"${XDG_CONFIG_HOME:-$HOME/.config}"/"$i"
	ln -s "$PWD"/"$i"	"${XDG_CONFIG_HOME:-$HOME/.config}"/"$i"
done
