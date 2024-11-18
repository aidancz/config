#!/bin/sh
# profile file, runs on login

# env
. "$HOME/.env"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
