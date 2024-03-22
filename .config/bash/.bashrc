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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vterm
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
# https://github.com/akermu/emacs-libvterm/blob/master/README.md#shell-side-configuration
