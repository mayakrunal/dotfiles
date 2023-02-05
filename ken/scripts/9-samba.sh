#!/bin/sh

#install samba & follow https://wiki.archlinux.org/title/Samba#Server
yay -S samba
sudo nvim /etc/samba/samba.cfg
#  workgroup = WORKGROUP
#  log file = /var/log/samba/%m.log
#  syslog only = yes
#[sambashare]
#comment = Ken's Samba Share
#path = /sambashare
#writable = yes
#browsable = yes
#create mask = 0700
#directory mask = 0700
#read only = no
#guest ok = no

sudo groupadd -r sambausers
sudo usermod -aG sambausers samba_user
sudo smbpasswd -a samba_user ## change the sharing password
sudo chown -R :sambausers /sambashare
sudo chmod 1770 :sambausers /sambashare

#add to firewall
firewall-cmd --permanent --add-service={samba,samba-client,samba-dc} --zone=home #change the zone accordigly
sudo systemctl enable --now smb
sudo systemctl enable --now nmb
