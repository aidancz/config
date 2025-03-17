# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source "$HOME/.shrc"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ prompt

# autoload -U colors && colors
# load colors

# PS1="(%{$fg[red]%}$ %{$fg[yellow]%}%n %{$fg[green]%}%M %{$fg[blue]%}%~%{$reset_color%}) "
# PS1="(%# %n %m %~) "
# PS1="%(0?..%?)(%# %n %m %~) "
# PS1="%F{blue}(%# %n %m %~) %f"
PS1="%F{blue}($ %m %n %~) %f"

# https://stackoverflow.com/questions/4466245/customize-zshs-prompt-when-displaying-previous-command-exit-code
# man zshmisc -> expansion of prompt sequences

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ variable & option

# WORDCHARS="${WORDCHARS/\//}"
# WORDCHARS parameter is used by "forward-word" etc to specify which character should be considered as part of a "word", run "echo $WORDCHARS" to view its content
# here the syntax is ${name/pattern/repl}, which replace the slash with nothing, see "man zshexpn" in the "parameter expansion" section for more details

WORDCHARS=""

setopt APPEND_HISTORY
# setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# setopt HIST_IGNORE_ALL_DUPS

setopt PRINT_EXIT_VALUE

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ function
open_terminal()
{
	setsid -f $TERMINAL >/dev/null 2>&1
}
zle -N open_terminal

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(zoxide init zsh --no-cmd)"
alias e="__zoxide_z"
alias ei="__zoxide_zi"

function fzf_cd() {
	local p
	p="$(fzf +m -q "$1")"
	if [ -d "$p" ]; then
		p="$p"
	else
		p="$(dirname "$p")"
	fi
	cd "$p"
}
# can't use $path in zsh
# https://superuser.com/questions/1733936/why-does-assigning-to-path-break-my-path-in-zsh
alias i="fzf_cd"

eval "$(atuin init zsh)"

# eval "$(starship init zsh)"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle

autoload edit-command-line; zle -N edit-command-line
autoload -U select-word-style; select-word-style whitespace

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_vi{{{

# bindkey -v

# bindkey -M viins -s "^[[91;5u" "^["
# bind ctrl-[ to esc

# bindkey -M viins "kj" vi-cmd-mode
# bind kj to esc

export KEYTIMEOUT=1
# wait ? hundredths of seconds (? 0.01s)

bindkey -M viins "^e" end-of-line
bindkey -M viins "^a" beginning-of-line
bindkey -M viins "^f" forward-char
bindkey -M viins "^b" backward-char
bindkey -M viins "^[f" emacs-forward-word
bindkey -M viins "^[b" emacs-backward-word
# bindkey -M viins "^n" forward-word

# "forward-word" and "end-of-line" is used by zsh-autosuggestions (see https://github.com/zsh-users/zsh-autosuggestions#usage)

bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^w" backward-kill-word
bindkey -M viins "^u" backward-kill-line
bindkey -M viins "^k" kill-line

# in viins, ^? (backspace) defaults to "vi-backward-delete-char", which won't delete past the point where insert mode was last entered

bindkey -M vicmd "^[[H" beginning-of-line
bindkey -M viins "^[[H" beginning-of-line
bindkey -M vicmd "^[[4~" end-of-line
bindkey -M viins "^[[4~" end-of-line
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M viins "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[OP" open_terminal
bindkey -M viins "^[OP" open_terminal
bindkey -M vicmd "^[OQ" edit-command-line
bindkey -M viins "^[OQ" edit-command-line

bindkey -M vicmd -s "^[[24~" "^[dd^d"
bindkey -M viins -s "^[[24~" "^[dd^d"
bindkey -M viins -s "^[OR" "^[ddiy^M"
bindkey -M vicmd -s "^[OR" "^[ddiy^M" # <esc>cc bug when line is empty...

#}}}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_emacs

bindkey -e

# bindkey -rp "^["
# bindkey -M emacs "^[" undefined-key
# bindkey -M emacs "^[" self-insert
# bindkey -M emacs "^[" redisplay
bindkey -M emacs "^[" beep
# bindkey -M emacs -s "^[" ""

bindkey -M emacs "^u"    backward-kill-line # https://stackoverflow.com/questions/3483604/which-shortcut-in-zsh-does-the-same-as-ctrl-u-in-bash
bindkey -M emacs "^[w"   emacs-forward-word # https://unix.stackexchange.com/questions/106375/make-zsh-alt-f-behave-like-emacs-alt-f
bindkey -M emacs "^[b"   emacs-backward-word
bindkey -M emacs "^[[H"  beginning-of-line
bindkey -M emacs "^[[4~" end-of-line
bindkey -M emacs "^[[A"  history-beginning-search-backward
bindkey -M emacs "^[[B"  history-beginning-search-forward
bindkey -M emacs "^[^M"  open_terminal
bindkey -M emacs "^[e"   edit-command-line

bindkey -M emacs -s "^[[27;2u" "^e^u^d"
bindkey -M emacs -s "^[f" "^e^uy^M"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tmux
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     exec tmux new-session -A -s ${USER} >/dev/null 2>&1
# fi

# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     exec tmux
# fi
