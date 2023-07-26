https://wiki.archlinux.org/title/Installation_guide
https://wiki.archlinux.org/title/General_recommendations



# pre-installation

## acquire an installation image

https://archlinux.org/download/

## verify signature

```sh
# https://archlinux.org/download/
# click `PGP signature`

gpg --keyserver-options auto-key-retrieve --verify archlinux-version-x86_64.iso.sig
```

## prepare an installation medium

https://wiki.archlinux.org/title/USB_flash_installation_medium

- command line

```sh
lsblk

sudo umount /dev/sdxn

sudo wipefs -af /dev/sdx

sudo cat ~/Downloads/archlinux-2022.03.01-x86_64.iso > /dev/sdx
# or
sudo cp ~/Downloads/archlinux-2022.03.01-x86_64.iso /dev/sdx
# or
sudo dd if=~/Downloads/archlinux-2022.03.01-x86_64.iso of=/dev/sdx bs=4M oflag=sync status=progress
```

- graphical tool

```sh
gnome-multi-writer
```

## boot the live environment

```sh
disable secure boot
# https://m.xitongzhijia.net/xtjc/20211107/231719.html

boot in uefi mode
```

## installation experience enhancement

```sh
setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz
alias c="clear"
bindkey -v # zsh
set -o vi # bash

vim keys.conf
#+keycode 58 = Escape
loadkeys keys.conf

vim .vimrc
#+syntax on
#+noremap J 5j
#+noremap K 5k
#+noremap H 0
#+noremap L $
#+noremap S :w<CR>
#+noremap q :q<CR>
```

## connect to the internet

```sh
ip link
ip link set wlan0 up
ip link

systemctl start dhcpcd
```

```sh
systemctl start iwd

iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect Redmi_9D3C
quit



	iwlist wlan0 scan
	iwlist wlan0 scan | grep ESSID
	
	wpa_passphrase Redmi_9D3C zrf412324 > internet.conf
	wpa_supplicant -c internet.conf -i wlan0 &> /dev/null &
```

```sh
ping baidu.com
```

## update the system clock

```sh
timedatectl status
# check the service status

timedatectl set-ntp true

timedatectl status
```

## partition the disks

```sh
fdisk -l

fdisk /dev/nvme0n1

p

g
n, 1(default), 2048(default), +512M
# use default value: enter
n, 2(default), 1050624(default), +1G
n, 3(default), 3147776(default), ?(default)

p

w
```

## format the partitions

```sh
mkfs.fat -F 32 /dev/nvme0n1p1

mkswap /dev/nvme0n1p2

mkfs.ext4 /dev/nvme0n1p3
```

## mount the file systems

```sh
mount /dev/nvme0n1p3 /mnt

mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

swapon /dev/nvme0n1p2
```



# installation

## select the mirrors

```sh
vim /etc/pacman.d/mirrorlist
wget "https://archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&use_mirror_status=on"
# https://archlinux.org/mirrorlist/
	#+Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
	#+Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

# /etc/pacman.d/mirrorlist will later be copied to the new system by pacstrap, so it is worth getting right
```

## install essential packages

```sh
pacstrap /mnt base linux linux-firmware
pacstrap /mnt base-devel dhcpcd iwd vim bash-completion
# to install other packages or package groups, append the names to the pacstrap command above (space separated) or use pacman while chrooted into the new system
```



# configure the system

## fstab

```sh
cat /mnt/etc/fstab

genfstab -U /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
# check the resulting /mnt/etc/fstab file
```

## chroot

```sh
cp /root/.vimrc /mnt/root

arch-chroot /mnt
# change root into the new system
# `exit` to exit
```

## time zone

```sh
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

hwclock --systohc
```

## localization

```sh
vim /etc/locale.gen
#-#en_US.UTF-8 UTF-8
#+en_US.UTF-8 UTF-8
locale-gen

vim /etc/locale.conf
#+LANG=en_US.UTF-8

vim /etc/vconsole.conf
#+FONT=LatGrkCyr-12x22.psfu.gz
```

## network configuration

```sh
vim /etc/hostname
#+hp

vim /etc/hosts
#+127.0.0.1	localhost
#+::1		localhost
#+127.0.0.1	hp.localdomain	hp
```

## root password

```sh
passwd
```

## boot loader

```sh
pacman -S grub efibootmgr amd-ucode os-prober

mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg

# `uname -m`, make sure the output is "x86_64"
grub-install --target=x86_64-efi --efi-directory=/boot
```



# reboot

```sh
exit
umount -R /mnt
shutdown -h now

# remove usb drive

# done!
```
