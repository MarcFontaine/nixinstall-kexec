# create partitions
set -e
parted -s /dev/sda -- mklabel msdos
parted -s /dev/sda -- mkpart primary 1MiB -512MiB
parted -s /dev/sda -- mkpart primary linux-swap -512MiB 100% 

echo 1>/sys/class/block/sda/device/rescan

yes | mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2

# mount file-systems
mount /dev/sda1 /mnt
swapon /dev/sda2
