bindkey '^o' edit-command-line

bindkey -v

#bindkey -M vicmd "j" down-line-or-history
#bindkey -M vicmd "k" up-line-or-history
#bindkey -M vicmd "h" vi-backward-char
#bindkey -M vicmd "l" vi-forward-char

bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line

bindkey "^l" forward-char
bindkey "^w" forward-word
