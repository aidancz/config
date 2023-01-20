# aidan

# cd $home
if [[ $PWD == $HOME ]]
then
	cd $home
fi

# option
setopt HIST_IGNORE_ALL_DUPS



# zshzle

bindkey -v
export KEYTIMEOUT=1			# if use "kj" or relavant, this value should be set >=20, other =1
#bindkey -s "^[[91;5u" "^["		# bind ctrl-[ to esc

# vicmd
#bindkey -M vicmd "j" down-line-or-history
#bindkey -M vicmd "k" up-line-or-history
#bindkey -M vicmd "h" vi-backward-char
#bindkey -M vicmd "l" vi-forward-char
bindkey -M vicmd "^h" vi-beginning-of-line
bindkey -M vicmd "^l" vi-end-of-line

# viins
#bindkey -M viins "kj" vi-cmd-mode
bindkey "^h" beginning-of-line
bindkey "^l" end-of-line		# https://github.com/zsh-users/zsh-autosuggestions#usage
bindkey "^w" backward-kill-word		# in viins, ^w defaults to "vi-backward-kill-word", which won't delete past the point where insert mode was last entered
bindkey "^u" backward-kill-line		# same reason as above
bindkey "^n" forward-word

# edit command via editor
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd "^e" edit-command-line
bindkey '^e' edit-command-line

# clear-screen ^l -> ^j
bindkey -M vicmd "^j" clear-screen
bindkey '^j' clear-screen



# source .zsh file in $ZDOTDIR
for i in "$ZDOTDIR"/*(.N)
do
	source $i
done

# https://github.com/zimfw/zimfw
ZIM_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/zim"
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# module config
	# zsh-completions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
	# completion
zstyle ':zim:completion' dumpfile		${XDG_CACHE_HOME}/zsh/zcompdump
zstyle ':completion::complete:*' cache-path	${XDG_CACHE_HOME}/zsh/zcompcache
# Initialize modules.
source ${ZIM_HOME}/init.zsh
_zsh_autosuggest_bind_widgets		# https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding






# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

## Basic auto/tab complete:
#autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
#compinit
#_comp_options+=(globdots)		# Include hidden files.

## vi mode
#bindkey -v
#export KEYTIMEOUT=1

## Use vim keys in tab complete menu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -v '^?' backward-delete-char

## Change cursor shape for different vi modes.
#function zle-keymap-select () {
#    case $KEYMAP in
#        vicmd) echo -ne '\e[1 q';;      # block
#        viins|main) echo -ne '\e[5 q';; # beam
#    esac
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

## Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line
#bindkey -M vicmd '^[[P' vi-delete-char
#bindkey -M vicmd '^e' edit-command-line
#bindkey -M visual '^[[P' vi-delete

## Load syntax highlighting; should be last.
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
