#!/bin/bash

#https://wiki.archlinux.org/title/Display_manager
#[Desktop Entry]
#Name=Openbox
#Comment=Log in using the Openbox window manager (without a session manager)
#Exec=/usr/bin/openbox-session
#TryExec=/usr/bin/openbox-session
#Icon=openbox.png
#Type=Application

cat > /usr/share/xsessions/dwm.desktop << EOL
[Desktop Entry]
Name=dwm
Comment=dwm
Exec=/usr/local/bin/dwm
TryExec=/usr/local/bin/dwm
EOL
