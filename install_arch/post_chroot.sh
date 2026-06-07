#!/bin/bash
set -euo pipefail

# root password
passwd

# Install boot manager and setup related configs
bootctl install

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

echo "Installation process complete!"
