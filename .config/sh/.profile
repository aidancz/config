#!/bin/sh
# profile file, runs on login

# * env

. "$HOME/.env"

# * startx

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
