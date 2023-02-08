#!/bin/sh

#install pamac and octopi
yay -S octopi octopi-notifier-frameworks pamac-all

#install visual studio code
yay -S visual-studio-code-bin

#install alacritty
sudo pacman -S alacritty

#install ventoy (if you want to make a usb live disk)
yay -S ventoy-bin

#install libreoffice
sudo pacman -S libreoffice-fresh hunspell hunspell-en_us gimp inkscape

#install virtualbox
yay -S virtualbox virtualbox-hostmodules-arch virtualbox-guest-iso virtualbox-ext-oracle

sudo usermod -a -G vboxusers ${USER}

#install discord
yay -S discord

#install kodi
yay -S kodi kodi-addons

#install obs-studio
yay -S obs-studio
