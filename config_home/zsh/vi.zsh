bindkey -v

# esc

#bindkey -s "^[[91;5u" "^[" # bind ctrl-[ to esc

export KEYTIMEOUT=1 # if use "kj" or relavant, this value should be set >=20, other =1
#bindkey -M viins "kj" vi-cmd-mode

# vicmd

#bindkey -M vicmd "j" down-line-or-history
#bindkey -M vicmd "k" up-line-or-history
#bindkey -M vicmd "h" vi-backward-char
#bindkey -M vicmd "l" vi-forward-char
bindkey -M vicmd "^h" vi-beginning-of-line
bindkey -M vicmd "^l" vi-end-of-line
bindkey -M vicmd "^f" edit-command-line

# viins

bindkey "^w" forward-word
bindkey "^l" end-of-line
bindkey "^h" beginning-of-line
# https://github.com/zsh-users/zsh-autosuggestions#usage
