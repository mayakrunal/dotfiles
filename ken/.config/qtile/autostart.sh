#!/bin/sh

xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VIRTUAL1 --off --output HDMI-1-0 --off &
# restore wallpaper
nitrogen --restore &
#notification agent
/usr/lib/notification-daemon-1.0/notification-daemon &
# polkit agent
/usr/lib/xfce-polkit/xfce-polkit &
# screen locker
xss-lock /usr/lib/kscreenlocker_greet &
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
