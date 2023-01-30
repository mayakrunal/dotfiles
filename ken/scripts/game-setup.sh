#!/bin/sh
#install the 32bit version of the graphics drivers
sudo pacman -S lib32-mesa lib32-nvidia-utils

#free arial fonts
sudo pacman -S ttf-liberation

#install the steam
sudo pacman -S steam-native-runtime

#install the directx 9 to 12 support
yay -S dxvk-bin vkd3d

#install wine for .net applications
sudo pacman -S wine wine-gecko wine-mono winetricks #to not donwload the packages for each profile
