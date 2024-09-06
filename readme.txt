config repo

# xdg variable

these vaviables are set at a shell script called "env"

some program can't read these variables by design,
i have to hard code the file path, use grep to find them

# config effective location

1. $HOME            (eg: ~/.profile) (~/.env is also this case)
2. $XDG_CONFIG_HOME (eg: ~/.config/clash)

# logic behind login

bash executes ~/.bash_profile, that's it
(login shell executes its profile, so if zsh is login shell, zsh executes ~/.zprofile)

https://wiki.archlinux.org/title/command-line_shell#Login_shell
