#!/bin/sh
# profile file, runs on login

# env
. "$HOME/.env"

# startx only if:
# 1. tty1
# 2. xorg not exist
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
