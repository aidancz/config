# * source

source "$HOME/.shrc"

# * prompt

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# https://misc.flogisoft.com/bash/tip_customize_the_shell_prompt
# https://stackoverflow.com/questions/16715103/bash-prompt-with-the-last-exit-code

# PS1="(\$ \u \h \w) "
# PS1="\e[1m(\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w\e[39m) \e[0m"
# PS1="\[\e[1m\](\[\e[31m\]\$ \[\e[33m\]\u \[\e[32m\]\h \[\e[34m\]\w\[\e[39m\]) \[\e[0m\]"

# PS1="\e[31mhello\e[0m "
# # type something like asdfasdfasdfasdf and press <c-u>, some letters are not deleted, so we need:
# PS1="\[\e[31m\]hello\[\e[0m\] "

PS1="\[\e[34m\](\$ \h \u \w) \[\e[0m\]"

# * key (can be inspected via: bind -X)

# (info "(bash)Bash Builtins")
# https://stackoverflow.com/questions/8366450/complex-keybinding-in-bash
# https://stackoverflow.com/questions/4200800/in-bash-how-do-i-bind-a-function-key-to-a-command

# bind "set show-mode-in-prompt on"
# 2026-04-13 wo cao

bind '"\C-x\C-e": edit-and-execute-command'

bind -x '"\eOP": exit'
# <f1>

bind -x '"\eOQ\r": setsid -f $TERMINAL >/dev/null 2>&1'
# <f2><cr>

eval "$(zoxide init bash)"
bind -x '"\eOQw": __zoxide_zi; kill -INT $$'
# <f2>w
# https://superuser.com/questions/1662055/how-to-bind-x-keyboard-shortcut-and-refresh-prompt

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
bind -x '"\eOQe": fzf_cd; kill -INT $$'
# <f2>e

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
bind -x '"\eOQf": y; kill -INT $$'
# <f2>f
# https://yazi-rs.github.io/docs/quick-start#shell-wrapper

bind -x '"\eOQv": nvim'
# <f2>v

bind -x '"\eOQx": tig'
# <f2>v
