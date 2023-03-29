#!/bin/sh

# restore wallpaper
nitrogen --restore &
#notification agent
/usr/lib/notification-daemon-1.0/notification-daemon &
# polkit agent
/usr/lib/xfce-polkit/xfce-polkit &
# screen locker
xss-lock /usr/lib/kscreenlocker_greet &
# turn on numlockx
numlockx &
# systray volume and network manager applet
volumeicon &
#network manager applet
nm-applet &
#bluetooth applet
blueman-applet &
# ime input methods
fcitx5 &
# start picom
picom &
