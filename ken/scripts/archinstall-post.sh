#!/bin/sh
#configure machine for ssh (make it easy if you are running it into vm)
sudo pacman -S openssh
sudo systemctl enable sshd.service
sudo systemctl start --now sshd.service

#on client side also install ssh & login to machine using
ssh user@ip

#pacman settings
sudo nvim /etc/pacman.conf #uncomment color,VerbosePkgLists,ParrallelDownloads && enable multilib repo

#update mirror list
sudo reflector --protocol https --country 'China,Japan' --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

#create user directories in home
sudo pacman -S xdg-user-dirs

#install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

#install xorg
sudo pacman -S xorg

#install minial kde & wayland session as well
#take pipewire-jack,wireplumber,phonon-qt-vlc
sudo pacman -S plasma plasma-wayland-session

#enable the sddm service at systemd
sudo systemctl enable sddm.service

#kde applications
sudo pacman -S firefox ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kate kdenlive kfind kgpg khelpcenter kleopatra kmag knotes konsole ksystemlog okular partitionmanager print-manager skanpage spectacle yakuake system-config-printer firewalld kwallet-pam kwalletmanager ksshaskpass

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

#install visual studio code
yay -S visual-studio-code-bin

#install alacritty
sudo pacman -S alacritty
