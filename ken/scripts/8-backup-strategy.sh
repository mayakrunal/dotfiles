#!/bin/sh
yay -S snapper snapper-gui-git

#snapper configuration(start from scrach assume no snaphots subvolumn)
sudo mount /dev/{brtfs root drive} /mnt
sudo btrfs sub cr /mnt/@snaphots
sudo umount /mnt

#create snapper config
snapper -c root create-config /

#delete the /.snapshots sub vol
sudo btrfs sub del /.snapshots/

#make snapshot folder (we are doing all these so that @snapshot subvol (which is directly under toplevel subvol point to snapshot vol)
sudo mkdir /.snapshots
#assume structure something like this
# subvolid=5
#   |
#   ├── @ -|
#   |     contained directories:
#   |       ├── /usr
#   |       ├── /bin
#   |       ├── /.snapshots
#   |       ├── ...
#   |
#   ├── @home
#   ├── @snapshots
#   ├── @var_log
#   └── @...

#find the subvol id of the @snapshots
sudo btrfs sub list /

#edit the fstab file
sudo nvim /etc/fstab
#update the file to showsomething like below notice the subvolId
### /dev/nvme0n1p8 LABEL=Arch
#UUID=60f38b09-1d1d-43b4-ba83-58029779179c   /.snapshots     btrfs       rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=277,subvol=/@snapshots  0 0

#make sure to enable the timers for root config

#add your self to #ALLOW_USERS
sudo nvim /etc/snapper/configs/root

#permission for sudo users
chmod a+rx .snapshots
chown :wheel .snapshots

#python script to rollback above layout system
yay -S snapper-rollback

sudo nvim etc/snapper-rollback.conf
