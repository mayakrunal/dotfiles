#!/bin/sh

xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VIRTUAL1 --off --output HDMI-1-0 --off &
# systray volume and network manager applet
volumeicon &
nm-applet &
blueman-applet &
# restore wallpaper
nitrogen --restore &
# start picom
picom &
# ime input methods
fcitx5 &
