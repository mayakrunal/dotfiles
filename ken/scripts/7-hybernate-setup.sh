#!/bin/sh

#find the swap UUID
sudo blkid #b55777aa-932a-40e7-a7e9-4f7ca8b30e91

#add resume kernal param
sudo nvim /etc/default/grub #GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=b55777aa-932a-40e7-a7e9-4f7ca8b30e91 quiet splash"

#add resume hook to mkinitcpio
sudo nvim /etc/mkinitcpio.conf #HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)

#regenrate the initramfs
sudo mkinitcpio -p linux

#regenerate grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg
