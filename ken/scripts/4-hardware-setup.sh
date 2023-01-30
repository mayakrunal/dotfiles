#!/bin/sh
#check the graphics cards
lspci -k | grep -A 2 -E "(VGA|3D)"
########### For intel ####################
sudo pacman -S mesa xf86-video-intel sof-firmware sof-tools #xf86-video-intel for the DDX 2d acceleration in xorg (for the sound sof-firmware (took way too long to figure it out since my laptop didn't detect it))

sudo pacman -S vulkan-intel vulkan-icd-loader vulkan-tools #vulkan support

sudo pacman -S intel-media-driver libva-utils #for VA- API

#install nvidia package (For the Maxwell (NV110/GM XXX ) series and newer)
sudo pacman -S nvidia nvidia-utils #nvidia-lts for lts kernal // For kepler series nvidia-470xx-dkms // For fermi nvidia-390xx-dkms

sudo nvim /etc/mkinitcpio.conf #remove the kms hook & reboot (after the nvidia is detected re add it)

#audio
sudo pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber

#enable the sound
systemctl enable --user pipewire
systemctl enable --user pipewire-pulse
systemctl enable --user wireplumber

#install printer driver (i have epson printer)
yay -S epson-inkjet-printer-escpr
