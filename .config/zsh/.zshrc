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

setopt INTERACTIVE_COMMENTS

setopt APPEND_HISTORY
# setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# setopt HIST_IGNORE_ALL_DUPS

setopt PRINT_EXIT_VALUE

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ function

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zle_eval

# zle_eval() {
# 	echo -en "\e[2K\r"
# 	eval "$@"
# 	zle redisplay
# }
# # posix

# function zle_eval {
# 	echo -en "\e[2K\r"
# 	eval "$@"
# 	zle redisplay
# }
# # bash / zsh only

# https://www.reddit.com/r/zsh/comments/96asgu/how_to_bindkey_shell_commands_a_quick_guide/
# https://github.com/theniceboy/.config/blob/master/zsh/mappings.zsh

zle_eval() {
	echo -en "\e[2K\r"
	eval "$@" </dev/tty
	# </dev/tty is for zle widget
	zle reset-prompt
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _exit

_exit() {
	zle_eval exit
}
zle -N _exit

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _term

_term() {
	zle_eval setsid -f $TERMINAL >/dev/null 2>&1
}
zle -N _term

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _yazi

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
_yazi() {
	zle_eval y
}
zle -N _yazi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _nvim

_nvim() {
	zle_eval nvim
}
zle -N _nvim

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _lazygit

_lazygit() {
	zle_eval lazygit
}
zle -N _lazygit

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _zoxide

eval "$(zoxide init zsh --no-cmd)"
# __zoxide_z
# __zoxide_zi
_zoxide() {
	zle_eval __zoxide_zi
}
zle -N _zoxide

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ _fzf

fzf_cd() {
	local p
	# p means path
	p="$(fzf --no-multi --query="$1")"
	if [ -d "$p" ]; then
		p="$p"
	else
		p="$(dirname "$p")"
	fi
	cd "$p"
}
_fzf() {
	zle_eval fzf_cd
}
zle -N _fzf
# can't use $path in zsh
# https://superuser.com/questions/1733936/why-does-assigning-to-path-break-my-path-in-zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ atuin

eval "$(atuin init zsh)"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ starship

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
# bindkey -M emacs "^[" beep
# bindkey -M emacs -s "^[" ""

bindkey -M emacs "^u"    backward-kill-line # https://stackoverflow.com/questions/3483604/which-shortcut-in-zsh-does-the-same-as-ctrl-u-in-bash
bindkey -M emacs "^[w"   emacs-forward-word # https://unix.stackexchange.com/questions/106375/make-zsh-alt-f-behave-like-emacs-alt-f
bindkey -M emacs "^[b"   emacs-backward-word
bindkey -M emacs "^[[H"  beginning-of-line
bindkey -M emacs "^[[4~" end-of-line
bindkey -M emacs "^[[A"  history-beginning-search-backward
bindkey -M emacs "^[[B"  history-beginning-search-forward
bindkey -M emacs "^x^e"  edit-command-line

bindkey -M emacs "^[OP"     _exit
bindkey -M emacs "^[[27;5u" _exit
bindkey -M emacs "^[OQ^M"   _term
bindkey -M emacs "^[OQe"    _zoxide
bindkey -M emacs "^[OQr"    _fzf
bindkey -M emacs "^[OQf"    _yazi
bindkey -M emacs "^[OQv"    _nvim
bindkey -M emacs "^[OQ "    _lazygit

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tmux
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     exec tmux new-session -A -s ${USER} >/dev/null 2>&1
# fi

# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     exec tmux
# fi
