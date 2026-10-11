#!/bin/sh

. "$HOME/.xprofile"

xinitdir="/etc/X11/xinit"
if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
# https://bbs.archlinux.org/viewtopic.php?id=308200
# https://wiki.archlinux.org/title/Xinit#xinitrc

exec dwm
