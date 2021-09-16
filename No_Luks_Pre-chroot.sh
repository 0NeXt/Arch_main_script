iwctl
ping archlinux.org
timedatectl set-ntp true
echo "sda1 as efi, sda2 as root, sda3 as swap and 8GB" && fdisk
mkfs.vfat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda2
mkswap /dev/sda3 
mount /dev/sda2 /mnt
cd /mnt
btrfs su cr @
btrfs su cr @home
cd ..
umount /mnt
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/home
mkdir -p /mnt/boot
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot
pacstrap /mnt base base-devel linux-zen linux-lts linux-firmware vim nano emacs vi grub networkmanager efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
echo "# /dev/sda3 LABEL=swap" >> /mnt/etc/fstab
echo "/dev/sda3 none  swap  defaults  0 0" >> /mnt/etc/fstab
pacman -Sy figlet lolcat
echo "Welp, were done with the biggining, download the part two with- you know what? I'll download it anyway..." | figlet | lolcat
git clone https://github.com/0NeXt/Arch_main_script/* /mnt/
