# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source "$HOME/.shrc"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ prompt

# autoload -U colors && colors
# load colors

PS1="(%# %n %m %~) "
# PS1="(%{$fg[red]%}$ %{$fg[yellow]%}%n %{$fg[green]%}%M %{$fg[blue]%}%~%{$reset_color%}) "
# man zshmisc -> expansion of prompt sequences

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ variable & option

WORDCHARS="${WORDCHARS/\//}"
# WORDCHARS parameter is used by "forward-word" etc to specify which character should be considered as part of a "word", run "echo $WORDCHARS" to view its content
# here the syntax is ${name/pattern/repl}, which replace the slash with nothing, see "man zshexpn" in the "parameter expansion" section for more details

# setopt hist_ignore_all_dups

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ function
open_terminal()
{
	setsid -f $TERMINAL >/dev/null 2>&1
}
zle -N open_terminal

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
function yyy { yy }
# ugly hack, yyy is a wrapper of yy
zle -N yyy

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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_vi{{{
bindkey -v

# bindkey -s "^[[91;5u" "^["
# bind ctrl-[ to esc

export KEYTIMEOUT=1
# wait ? hundredths of seconds (? 0.01s)

autoload edit-command-line; zle -N edit-command-line

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vicmd
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[[H" beginning-of-line
bindkey -M vicmd "^[[4~" end-of-line
# bindkey -M vicmd "^r" clear-screen
bindkey -M vicmd "^[OQ" edit-command-line
bindkey -M vicmd -s "^[[24~" "^[dd^d"

bindkey -M vicmd "^[OP" open_terminal
bindkey -M vicmd -s "^[OR" "^[ddiyyy^M"

	# bindkey -M vicmd "j" down-line-or-history
	# bindkey -M vicmd "k" up-line-or-history
	# bindkey -M vicmd "h" vi-backward-char
	# bindkey -M vicmd "l" vi-forward-char

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ viins
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward
bindkey -M viins "^[[H" beginning-of-line
bindkey -M viins "^[[4~" end-of-line
# bindkey -M viins "^r" clear-screen
bindkey -M viins "^[OQ" edit-command-line
bindkey -M viins -s "^[[24~" "^[dd^d"

bindkey -M viins "^[OP" open_terminal
bindkey -M viins -s "^[OR" "^[ddiyyy^M"
# <esc>cc bug when line is empty...

bindkey -M viins "^e" end-of-line
bindkey -M viins "^a" beginning-of-line
bindkey -M viins "^f" forward-char
bindkey -M viins "^b" backward-char
bindkey -M viins "\ef" forward-word
bindkey -M viins "\eb" backward-word

bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^w" backward-kill-word
bindkey -M viins "^u" backward-kill-line
bindkey -M viins "^k" kill-line

# bindkey -M viins "kj" vi-cmd-mode
# bindkey -M viins "^n" forward-word

# "forward-word" and "end-of-line" is used by zsh-autosuggestions (see https://github.com/zsh-users/zsh-autosuggestions#usage)
# in viins, ^? (backspace) defaults to "vi-backward-delete-char", which won't delete past the point where insert mode was last entered
#}}}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_emacs

# bindkey -e

bindkey -M emacs "\ef" emacs-forward-word
bindkey -M emacs "\eb" emacs-backward-word
bindkey -M emacs "^u" backward-kill-line
# https://unix.stackexchange.com/questions/106375/make-zsh-alt-f-behave-like-emacs-alt-f
# https://stackoverflow.com/questions/3483604/which-shortcut-in-zsh-does-the-same-as-ctrl-u-in-bash
