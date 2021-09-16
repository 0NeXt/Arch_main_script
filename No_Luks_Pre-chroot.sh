echo "Starting first stage"
pacman -yS
echo "if the pacman sync worked it means your connected and don't need the iwctl, but if it failed use iwctl"
echo "If you need it, to use iwctl you put     devices    to list the devices, then    station device_name get-networks    to find your network, then    station device_name connect networkname   put your password and wait 5 secs to vertify  if it's connected or not, then you can put exit to continue."
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
mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/sda2 /mnt/home
mount /dev/sda1 /mnt/boot
pacman -yS archlinux-keyring
pacstrap /mnt base base-devel linux-zen linux-lts linux-firmware vim nano emacs vi grub networkmanager efibootmgr archlinux-keyring
genfstab -U /mnt >> /mnt/etc/fstab
echo "# /dev/sda3 LABEL=swap" >> /mnt/etc/fstab
echo "/dev/sda3 none  swap  defaults  0 0" >> /mnt/etc/fstab
pacman -S figlet lolcat
echo "Welp, were done with the beginning, download the part two with- you know what? I'll download it anyway..." | figlet | lolcat
mkdir /mnt/gittttesst
git clone https://github.com/0NeXt/Arch_main_script/* /mnt/gittttesst
mv /mnt/gittttesst/No_Luks_Pre-chroot.sh /mnt/install.sh
rm -rf /mnt/gittttesst
echo "Now chrooting, run the sh file in the / directory for part two" | figlet | lolcat 
arch-chroot /mnt
