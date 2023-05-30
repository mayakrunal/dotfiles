#!/bin/sh
# start waybar and programs with tray icons after pause
waybar &
sleep 1
nm-applet --indicator &
blueman-applet &
fcitx5 &
astrill &
numlockx on &
xwaylandvideobridge &
