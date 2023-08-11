# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source "$XDG_CONFIG_HOME/.sh/shrc"
source "$XDG_CACHE_HOME/mdf/m_zshnameddir"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ prompt
autoload -U colors && colors
# load colors
PS1="(%{$fg[red]%}$ %{$fg[yellow]%}%n %{$fg[green]%}%M %{$fg[blue]%}%~%{$reset_color%}) "
# man zshmisc -> expansion of prompt sequences

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ variable & option
WORDCHARS="${WORDCHARS/\//}"
# WORDCHARS parameter is used by "forward-word" etc to specify which character should be considered as part of a "word", run "echo $WORDCHARS" to view its content
# here the syntax is ${name/pattern/repl}, which replace the slash with nothing, see "man zshexpn" in the "parameter expansion" section for more details
setopt hist_ignore_all_dups

# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_vi{{{
# bindkey -v
# #bindkey -s "^[[91;5u" "^["			# bind ctrl-[ to esc
# export KEYTIMEOUT=1				# if use "kj" or relavant, this value should be set >=20, other =1

# # vicmd
# #bindkey -M vicmd "j" down-line-or-history
# #bindkey -M vicmd "k" up-line-or-history
# #bindkey -M vicmd "h" vi-backward-char
# #bindkey -M vicmd "l" vi-forward-char

# # viins
# #bindkey -M viins "kj" vi-cmd-mode
# bindkey "^h" beginning-of-line
# bindkey "^l" end-of-line			# https://github.com/zsh-users/zsh-autosuggestions#usage
# bindkey "^n" forward-word
# bindkey "^?" backward-delete-char		# in viins, ^? defaults to "vi-backward-delete-char", which won't delete past the point where insert mode was last entered
# bindkey "^w" backward-kill-word		# same reason as above
# bindkey "^u" backward-kill-line		# same reason as above

# # edit command via editor
# autoload edit-command-line; zle -N edit-command-line
# bindkey -M vicmd "^e" edit-command-line
# bindkey '^e' edit-command-line

# # clear-screen ^l -> ^r
# bindkey -M vicmd "^r" clear-screen
# bindkey '^r' clear-screen
# #}}}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zshzle_emacs
bindkey -e
bindkey '\ef' emacs-forward-word
bindkey '\eb' emacs-backward-word
bindkey '^u' backward-kill-line
# https://unix.stackexchange.com/questions/106375/make-zsh-alt-f-behave-like-emacs-alt-f
# https://stackoverflow.com/questions/3483604/which-shortcut-in-zsh-does-the-same-as-ctrl-u-in-bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ quick cd
bindkey -s '^s' '^ucd "$(dirname "$(fzf)")"\n'
# bind ctrl-s

lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^[s' '^ulfcd\n'
# bind alt-s

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zimfw (https://github.com/zimfw/zimfw){{{
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zim_home
ZIM_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/zim"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ download zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ config_zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ config_completion
zstyle ':zim:completion' dumpfile		$ZIM_HOME/zcompdump
zstyle ':completion::complete:*' cache-path	$ZIM_HOME/zcompcache
# https://github.com/zimfw/completion#settings

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ initialize modules
source ${ZIM_HOME}/init.zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ after init
# _zsh_autosuggest_bind_widgets
# https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
#}}}
