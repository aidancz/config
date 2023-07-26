init login

```sh
# login as root

ip link
ip link set wlan0 up
systemctl start dhcpcd
systemctl start iwd
iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect Redmi_9D3C
quit
```



# system administration

## users and groups

```sh
useradd -m -G wheel aidan
passwd aidan

ln -s /usr/bin/vim /usr/bin/vi
visudo
#-# %wheel ALL=(ALL:ALL) ALL
#+%wheel ALL=(ALL:ALL) ALL

cp /root/.vimrc /home/aidan
exit
# login as aidan
```



# package management

## pacman

```sh
sudo -e /etc/pacman.conf
#-#Color
#+Color
#
#+[archlinuxcn]
#+SigLevel = Never
#+Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
# https://github.com/archlinuxcn/repo

pacman -Syyu --noconfirm

pacman -S archlinuxcn-keyring

pacman -S downgrade
```



# let's download!

```sh
pacman -S yay # archlinuxcn
pacman -S wget curl git

pacman -S man tldr
```

```sh
# display server

pacman -S xorg
	pacman -S hsetroot
	pacman -S picom
```

```sh
# display drivers

pacman -S xf86-video-amdgpu
```

```sh
# window managers

sudo -e /etc/hosts
#+140.82.113.4	github.com
# https://github.com/521xueweihan/GitHub520

mkdir

git clone https://github.com/AidanUnhappy/dwm.git
sudo make clean install

git clone https://github.com/AidanUnhappy/script.git

git clone https://github.com/AidanUnhappy/st.git
sudo make clean install
yay -S libxft-bgra
# https://www.reddit.com/r/suckless/comments/k5k4sm/st_keeps_crashing_when_displaying_emojis/

pacman -S dmenu

yay -S google-chrome
```

```sh
# display manager

pacman -S xorg-xinit
# https://wiki.archlinux.org/title/Xinit

cp /etc/X11/xinit/xinitrc ~/.xinitrc
vim ~/.xinitrc
#-twm &
#-xclock -geometry 50x50-1+1 &
#-xterm -geometry 80x50+494+51 &
#-xterm -geometry 80x20+494-0 &
#-exec xterm -geometry 80x66+0+0 -name login
#+
#+exec dwm

# autostart x at login:
# https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
vim ~/.zprofile
# login shell initialization file (bash: ~/.bash_profile, zsh: ~/.zprofile)
#+exec startx

# to run xorg as a regular user:
startx # not now!
```

```sh
# power management

pacman -S polkit
# https://wiki.archlinux.org/title/Systemd#Power_management

pacman -S brightnessctl

	pacman -S xfce4-power-manager
```

```sh
# multimedia

	pacman -S alsa-utils # amixer
	sudo -e /etc/asound.conf
	#+defaults.pcm.card 1
	#+defaults.pcm.device 0
	#+defaults.ctl.card 1
	# https://blog.fearcat.in/a?ID=01050-2a2a6a1f-a8c0-4d1e-96ab-14050ffb4cb5



pacman -S bluez bluez-utils
sudo -e /etc/bluetooth/main.conf
#+FastConnectable = true
#+AutoEnable=true
#+Experimental = true
sudo systemctl enable --now bluetooth

pacman -S pulseaudio-alsa pulseaudio-bluetooth pavucontrol

pulseaudio --start
	pulseaudio -k

bluetoothctl
power on
agent on
default-agent
scan on
pair 84:26:7A:34:0E:B3
trust 84:26:7A:34:0E:B3
connect 84:26:7A:34:0E:B3
	remove 84:26:7A:34:0E:B3

# https://bbs.archlinuxcn.org/viewtopic.php?pid=43002#p43002
```

```sh
# networking

pacman -S network-manager-applet
sudo systemctl enable NetworkManager.service
```

```sh
# laptop touchpads

pacman -S xf86-input-synaptics
```

```sh
# fonts

pacman -S adobe-source-code-pro-fonts
# console

pacman -S ttf-liberation
# english

pacman -S adobe-source-han-sans-cn-fonts
pacman -S adobe-source-han-sans-tw-fonts
# chinese

pacman -S noto-fonts
pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

```sh
# hidpi

# https://wiki.archlinux.org/title/xorg#Display_size_and_DPI
# https://wiki.archlinux.org/title/HiDPI

vim ~/.Xresources
#+Xft.dpi: 108
# 108 = 96 + 12
```



# dwm

init

```sh
shutdown -h now

startx
```

## proxy

```sh
# https://archlinuxstudio.github.io/ArchLinuxTutorial/#/rookie/transparentProxy

pacman -S v2ray

pacman -S qv2ray
pacman -S qv2ray-plugin-ssr-dev-git
# configure qv2ray

pacman -S cgproxy
sudo -e /etc/cgproxy/config.json
#-"cgroup_proxy": [],
#+"cgroup_proxy": ["/"],
sudo setcap "cap_net_admin,cap_net_bind_service=ep" /usr/bin/v2ray
systemctl enable --now cgproxy.service

sudo -e /etc/resolv.conf
#+nameserver 8.8.8.8
#+nameserver 2001:4860:4860::8888
#+nameserver 8.8.4.4
#+nameserver 2001:4860:4860::8844
sudo chattr +i /etc/resolv.conf
```

```sh
# https://blog.linioi.com/posts/clash-on-arch/
# https://hsingko.github.io/post/2021/07/05/how-to-use-clash-subscribe/
# https://zhuanlan.zhihu.com/p/396272999

pacman -S clash

clash
# generate config file in ~/.config/clash, ctrl+c to exit
nvim /home/aidan/.config/clash/config.yaml
# copy config
#-port: 7890
#+port: 8889

sudo systemctl enable --now clash@aidan
systemctl status clash@aidan

http://clash.razord.top
or
git clone https://github.com/Dreamacro/clash-dashboard.git
cd clash-dashboard
git checkout -b gh-pages origin/gh-pages
nvim /home/aidan/.config/clash/config.yaml
#+external-ui: /path/to/clash-dashboard
http://127.0.0.1:9090/ui/#/proxies
```

```sh
	# https://www.91ajs.com/information/google-chrome-ajiasu-socks5-proxy.html
	mkdir ~/proxy
	wget https://github.com/FelisCatus/SwitchyOmega/releases/download/v2.5.20/SwitchyOmega_Chromium.crx
	mv SwitchyOmega_Chromium.crx SwitchyOmega_Chromium.zip
	unzip SwitchyOmega_Chromium.zip -d switchyOmega
```

```sh
sudo -e /etc/pacman.d/mirrorlist
wget "https://archlinux.org/mirrorlist/?country=HK&protocol=http&protocol=https&ip_version=4&use_mirror_status=on"
# https://archlinux.org/mirrorlist/

sudo -e /etc/sudoers
#+Defaults env_keep += "ftp_proxy http_proxy https_proxy no_proxy"
sudo -e /etc/pacman.d/gnupg/dirmngr.conf
#+honor-http-proxy
# https://wiki.archlinux.org/title/pacman#Pacman_does_not_honor_proxy_settings
# https://wiki.archlinux.org/title/Sudo#Environment_variables
```

## cli

```sh
pacman -S zsh
chsh -s /usr/bin/zsh aidan

pacman -S neovim

pacman -S ranger

git clone https://github.com/AidanUnhappy/config.git
./init.sh

shutdown -r now
```

```sh
pacman -S xclip
pacman -S fzf
yay -S ccat
```

```sh
# zsh

# https://github.com/zimfw/zimfw

pacman -S neofetch

pacman -S tree
```

```sh
# nvim

pacman -S python python-pip
pip3 install pynvim
pip3 install --upgrade pynvim
# https://github.com/neovim/pynvim

su
curl -sL install-node.vercel.app/lts | bash
exit
# https://github.com/neoclide/coc.nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# https://github.com/junegunn/vim-plug

# `:PlugInstall`
# https://github.com/junegunn/vim-plug#commands
```

```sh
# ranger

pacman -S ueberzug
# preview image
# https://github.com/ranger/ranger/wiki/Image-Previews#with-ueberzug
yay -S epub-thumbnailer-git
# preview epub
# scope.sh in ranger config

pacman -S zathura zathura-pdf-mupdf
# https://wiki.archlinux.org/title/zathura
yay -S zaread-git
pacman -S libreoffice-fresh
pacman -S jdk-openjdk # optional dependencies
# https://github.com/paoloap/zaread
# https://aur.archlinux.org/packages/zaread-git
	pacman -S pandoc

pacman -S feh
yay -S h-m-m-git

pacman -S trash-cli
```



# app

## file manager

```sh
pacman -S thunar
```

## cloud

```sh
pacman -S nutstore

yay -S electron11-bin
yay -S baidunetdisk-electron

rslsync
pacman -S rslsync
systemctl enable --now rslsync
http://localhost:8888
# https://program-think.blogspot.com/2015/01/BitTorrent-Sync.html
# https://program-think.blogspot.com/2017/08/GFW-Resilio-Sync.html
mkdir ~/rslsync
sudo setfacl -R -m "u:rslsync:rwx" /home/aidan
# https://kenfavors.com/code/how-to-add-user-permissions-to-a-folder-in-ubuntu/

pacman -S qbittorrent-enhanced-git
# https://github.com/XIU2/TrackersListCollection
# https://mp.weixin.qq.com/s/8pq51vkhiNh-y2eNyBdsiQ
test:
# https://ubuntu.com/download/alternative-downloads#bittorrent
	pacman -S aria2
```

## fcitx

```sh
# https://wiki.archlinux.org/title/Fcitx5
# https://sspai.com/post/72622
# https://sspai.com/post/42667

pacman -S fcitx5-im
pacman -S fcitx5-chinese-addons
pacman -S fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl
yay -S fcitx5-solarized
sudo -e /etc/environment
#+GTK_IM_MODULE=fcitx
#+QT_IM_MODULE=fcitx
#+XMODIFIERS=@im=fcitx
#+SDL_IM_MODULE=fcitx
```

## general

```sh
# password

pacman -S keepassxc
```

```sh
# pdf

pacman -S pdfarranger

pacman -S xournalpp
# add image, text
```

```sh
# image

pacman -S imagemagick
```

```sh
# office

	pacman -S libreoffice-fresh
```

```sh
# screen capture

pacman -S flameshot
```

## gtk and qt themes

- gtk

```sh
	pacman -S lxappearance
	# https://wiki.archlinux.org/title/GTK#Configuration_tools
	pacman -S qt5ct

yay -S qt5-styleplugins
# https://wiki.archlinux.org/title/qt#Styles_in_Qt_5

pacman -S arc-solid-gtk-theme
pacman -S arc-icon-theme
```
