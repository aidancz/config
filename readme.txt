config repo

# install

`git clone --recurse-submodules https://github.com/aidancz/config.git`

shell scripts are placed in .local/bin
run `.local/bin/set-symbolic-link` to set symbolic link

# dark light switch

dark:  `set-symbolic-link_appearance dark`
light: `set-symbolic-link_appearance light`

# xdg variables

these vaviables are set in a shell script .config/sh/.env

some programs can't read these variables by design
i have to hard code the file path
use grep to find them

# config effective location

1. $HOME            (eg: ~/.profile)
2. $XDG_CONFIG_HOME (eg: ~/.config/clash)

# logic behind login

bash executes ~/.bash_profile, that's it
(login shell executes its profile, so if zsh is login shell, zsh executes ~/.zprofile)

https://wiki.archlinux.org/title/command-line_shell#Login_shell
