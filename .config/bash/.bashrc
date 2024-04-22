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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
bind -m vi-insert  -x '"\eOP":"lfub"'
bind -m vi-command -x '"\eOP":"lfub"'
# https://stackoverflow.com/questions/4200800/in-bash-how-do-i-bind-a-function-key-to-a-command
