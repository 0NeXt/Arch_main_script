echo "Starting first stage"
pacman -yS
echo "if the pacman sync worked it means your connected and don't need the iwctl, but if it failed use iwctl"
echo "If you need it, to use iwctl you put     devices    to list the devices, then    station device_name get-networks    to find your network, then    station device_name connect networkname   put your password and wait 5 secs to vertify  if it's connected or not, then you can put exit to continue."
iwctl
ping archlinux.org
timedatectl set-ntp true
echo "sda1 as efi, sda2 as root, sda3 as swap and 8GB. Remember, if you can't use this fdisk, it will prompt you with cfdisk after, you can use it or not. Just use one of them"
fdisk
mkfs.vfat -F32 /dev/sda1
cryptsetup -y -v luksFormat /dev/sda2
cryptsetup open /dev/sda2 ArchLinux
mkswap /dev/sda3 
mount /dev/mapper/ArchLinux /mnt
cd /mnt
btrfs su cr @
btrfs su cr @home
cd ..
umount /mnt
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/mapper/Archlinux /mnt
mkdir -p /mnt/home
mkdir -p /mnt/boot
mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/mapper/ArchLinux /mnt/home
mount /dev/sda1 /mnt/boot
pacman -yS archlinux-keyring
pacstrap /mnt base base-devel linux-zen linux-lts linux-firmware vim nano emacs vi grub networkmanager efibootmgr archlinux-keyring
genfstab -U /mnt >> /mnt/etc/fstab
echo "# /dev/sda3 LABEL=swap" >> /mnt/etc/fstab
echo "/dev/sda3 none  swap  defaults  0 0" >> /mnt/etc/fstab
pacman -S figlet lolcat
echo "Welp, were done with the beginning..." | figlet | lolcat
mkdir /mnt/gittttesst
git clone https://github.com/0NeXt/Arch_main_script/ /mnt/gittttesst
mv /mnt/gittttesst/Stage2.sh /mnt/stage2.sh
mv /mnt/gittttesst/Stage3.sh /mnt/stage3.sh
rm -rf /mnt/gittttesst
echo "Now chrooting, run the stage2.sh file in the / directory for part two" | figlet | lolcat 
arch-chroot /mnt
