#!/bin/bash



# libinput
#https://wiki.archlinux.org/title/libinput#Via_xinput

#device=`xinput list | grep "TouchPad" | cut -d= -f2 | cut -f1`
#option_tap=`xinput list-props $device | grep "Tapping Enabled (" | cut -d'(' -f2 | cut -d')' -f1`
#option_scroll=`xinput list-props $device | grep "Natural Scrolling Enabled (" | cut -d'(' -f2 | cut -d')' -f1`
#option_speed=`xinput list-props $device | grep "libinput Accel Speed (" | cut -d'(' -f2 | cut -d')' -f1`
#
#xinput set-prop $device $option_tap 1
#xinput set-prop $device $option_scroll 1
#xinput set-prop $device $option_speed 0.3



# synaptics
#https://wiki.archlinux.org/title/Touchpad_Synaptics#Synclient

synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient FingerLow=5
synclient FingerHigh=10

synclient MinSpeed=0
synclient MaxSpeed=4
synclient AccelFactor=0.02
synclient CoastingSpeed=20

synclient VertTwoFingerScroll=1
synclient VertScrollDelta=-114
synclient HorizTwoFingerScroll=1
synclient HorizScrollDelta=-114

synclient PalmDetect=0

#/etc/X11/xorg.conf.d/70-synaptics.conf
#
#Section "InputClass"
#        Identifier "touchpad"
#        Driver "synaptics"
#        MatchIsTouchpad "on"
#		Option "TapButton1" "1"
#		Option "TapButton2" "3"
#		Option "TapButton3" "2"
#		Option "MinSpeed" "0"
#		Option "MaxSpeed" "4"
#		Option "AccelFactor" "0.02"
#		Option "CoastingSpeed" "20"
#		Option "VertTwoFingerScroll" "on"
#		Option "VertScrollDelta" "-114"
#		Option "HorizTwoFingerScroll" "on"
#		Option "HorizScrollDelta" "-114"
#		Option "PalmDetect" "1"
#EndSection
