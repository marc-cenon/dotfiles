#!/bin/bash

# wallpaper
nitrogen --restore &
# dunst
dunst &

# network tools
#nm-applet &

#picom
picom &

#vmware c/p
vmware-user-suid-wrapper &

#gnome-keyring
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

#azerty layout
setxkbmap fr
