#!/bin/sh
#check internet connection
ip link

#connect to wifi using iwctl
iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect SSID

#update system clock
timedatectl status

#create partitions
fdisk -l #list the drives

fdisk /dev/vda #enter the fdisk utility

#create following partitions
/boot #linux partition type EFI at least 500MB
swap  #linux swap parition (Double the size of your RAM)
/home #ext4 partition
/root #btrfs partition

#format the partitions
mkfs.fat -F32 /dev/vda1 #boot parition as fat32
mkswap /dev/vda2        #crate swap
swapon /dev/vda2        #enable swap
mkfs.ext4 /dev/vda3     #create ext4 home partition
mkfs.btrfs /dev/vda4    #btrfs root partition

#create btrfs subvolumes
mount /dev/vda4 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@varlog
btrfs su cr /mnt/@varcache
umount /mnt

#mount the subvolumes, boot & home partitions
mount -o noatime,compress=zstd,space_cache=v2,subvol=@ /dev/vda4 /mnt

#create subvolume folders
mkdir /mnt/{boot,home,var,opt,tmp}

mount -o noatime,compress=zstd,space_cache=v2,subvol=@varlog /dev/vda4 /mnt/var/log
mount -o noatime,compress=zstd,space_cache=v2,subvol=@varcache /dev/vda4 /mnt/var/cache

#mount boot & home
mount /dev/vda1 /mnt/boot
mount /dev/vda3 /mnt/home

#install essential packages
pacstrap -K /mnt base linux linux-firmware vi neovim btrfs-progs dosfstools exfatprogs ntfs-3g networkmanager man-db man-pages texinfo

#generate fstab
genfstab -U /mnt >>/mnt/etc/fstab

#arch-chroot into new system
arch-chroot /mnt

#settimezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

#localizaton en_US.UTF-8
nvim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >>/etc/locale.conf

#localhostname
echo "vm-arch-kde" >>/etc/hostname
nvim /etc/hosts
##127.0.0.1	localhost
##::1		localhost
##127.0.1.1	myhostname.localdomain	myhostname

#set root password
passwd #vm@123

#remaining essential tools
pacman -S grub grub-btrfs inotify-tools efibootmgr base-devel linux-headers os-prober reflector git mtools

#add btrfs moudle to mkinitcpio
nvim /etc/mkinitcpi.conf

#recreate the image
mkinitcpio -p linux

#bluetooth & printer
pacman -S bluez bluez-utils cups avahi nss-mdns

nvim /etc/nsswitch.conf #this is for avahi
#change host line as below
#hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns

#add user & add to sudo (wheel) group
useradd-mG wheel vm
passwd vm          #vm@123
EDITOR=nvim visudo #umcommment %wheel ALL=(ALL) ALL

#install the grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ArchGrub
#edit the default grub
nvim /etc/default/grub #enable os-prober #GRUB_DISABLE_OS_PROBER=false
grub-mkconfig -o /boot/grub/grub.cfg

#enable the services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable avahi-daemon.service

#unmount all drives & reboot
exit

umount -R /mnt

shutdown now

#after reboot
nmtui #terminal ui to login to network
