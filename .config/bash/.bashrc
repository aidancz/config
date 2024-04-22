# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source "$HOME/.shrc"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ prompt
# PS1="(\$ \u \h \w) "
# PS1="\e[1m(\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w\e[39m) \e[0m"
# PS1="\[\e[1m\](\[\e[31m\]\$ \[\e[33m\]\u \[\e[32m\]\h \[\e[34m\]\W\[\e[39m\]) \[\e[0m\]"

PS1="(\$ \u \h \W) "

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ lfcd
# lfcd () {
lfubcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    # lf -last-dir-path="$tmp" "$@"
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
bind -m vi-insert  '"\eOP":"\ecclfubcd\n"'
bind -m vi-command '"\eOP":"\ecclfubcd\n"'
# \e cc lfubcd \n
# https://stackoverflow.com/questions/4200800/in-bash-how-do-i-bind-a-function-key-to-a-command
# https://stackoverflow.com/questions/8366450/complex-keybinding-in-bash

