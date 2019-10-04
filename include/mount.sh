mkdir /mnt/cdrom
mount -t auto /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
./VBoxLinuxAdditions.run
mount -t vboxsf local_source /home/bbashop/www