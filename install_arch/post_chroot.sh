#!/bin/bash
### WARNING THIS SCRIPT CANNOT USE STDIN ###
set -euo pipefail

echo -e "\e[32mRunning post ch_root script...\e[0m"

echo "root:toor" | chpasswd

# Install boot manager and setup related configs
bootctl install

# Ensure mountpoint exists
mountpoint -q /boot || { echo -e "\e[31mERROR: /boot not mounted\e[0m"; exit 1; }

cat << EOF > /boot/loader/loader.conf
default  arch.conf
timeout  4
console-mode max
editor   no
EOF

# Configs for systemd-boot
cat << EOF > /boot/loader/entries/arch.conf
title   Arch Linux (linux)
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=${1} rw
EOF

cat << EOF > /boot/loader/entries/arch-lts.conf
title   Arch Linux (linux-lts)
linux   /vmlinuz-linux-lts
initrd  /amd-ucode.img
initrd  /initramfs-linux-lts.img
options root=PARTUUID=${1} rw
EOF

echo -e "\e[32mInstallation process complete!\e[0m"
echo -e "\e[32mThe root password is: toor\e[0m"
