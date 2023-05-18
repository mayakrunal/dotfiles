#!/bin/sh


#install xorg
sudo pacman -S xorg

#install minial kde & wayland session as well
#take pipewire-jack,wireplumber,phonon-qt-vlc
sudo pacman -S plasma plasma-wayland-session

#enable the sddm service at systemd
sudo systemctl enable sddm.service

#kde applications
sudo pacman -S wget firefox ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kate kdenlive kfind kgpg khelpcenter kleopatra kmag knotes konsole ksystemlog okular partitionmanager print-manager skanpage spectacle yakuake system-config-printer firewalld kwallet-pam kwalletmanager ksshaskpass

#enable the firewall
sudo systemctl enable firewalld.service

#input method
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-configtool
nvim .bash_profile #add following
#GTK_IM_MODULE=fcitx
#QT_IM_MODULE=fcitx
#XMODIFIERS=@im=fcitx

#install the fonts
sudo pacman -S adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts

#install astrill vpn
yay -S astrill gtk2 #astill still uses gtk2

#install reflector simple
yay -S reflector-simple
