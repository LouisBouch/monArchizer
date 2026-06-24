#!/bin/bash
set -euo pipefail

# Ensure script can only be run in ISO environment.
if ! grep -q "archiso" /proc/cmdline; then
  echo -e "\e[31mERROR: The script can only run in the Arch ISO environment.\e[0m"
  exit 1
fi

# Ensure script can only be run once to prevent corruption.
LOCKFILE="/run/script_run.lock"
if [[ -f "$LOCKFILE" ]]; then
  echo -e "\e[31mERROR: The installation script has already run on this ISO.\e[0m"
  echo -e "\e[31mERROR: To run it again, reboot the ISO environment.\e[0m"
  exit 1
fi

### Variables used inside the script to be modified by user ###

if [[ "$#" -ne 1 ]]; then
  echo "Usage: install_arch.sh [DISK]"
  echo "Example: install_arch.sh /dev/sda"
  exit 1
fi

DISK=$1

# Size of 0 represents remaining disk space.
BOOTSIZE="+2G"
SWAPSIZE="+16G"
ROOTSIZE="+150G"
HOMESIZE="0"

###############################################################

### Verify validity of command

if ! grep -q "AuthenticAMD" /proc/cpuinfo ; then
  echo "Script requires AMD CPU"
  exit 1
fi

if [[ ! "${DISK: -1}" == [a-zA-Z0-9] || ! -b "$DISK" ]]; then
  echo "Invalid disk name"
  echo "Example: install_arch.sh /dev/sda"
  exit 1
fi

### Fixed variable (DO NOT TOUCH)

if [[ "${DISK: -1}" == [0-9] ]]; then
  PARTSUFFIX="p"
else
  PARTSUFFIX=""
fi

EFI=1
SWAP=2
ROOT=3
HOM=4

EFIPART="${DISK}${PARTSUFFIX}${EFI}"
SWAPPART="${DISK}${PARTSUFFIX}${SWAP}"
ROOTPART="${DISK}${PARTSUFFIX}${ROOT}"
HOMEPART="${DISK}${PARTSUFFIX}${HOM}"
SCRIPTDIR=$(dirname -- "${BASH_SOURCE[0]}")

### WARNING

echo -e "\e[31mWARNING: This script will wipe '$DISK' forever.\e[0m"
echo -e "\e[31mWARNING: This script only works on AMD architectures.\e[0m"
echo -e "\e[31mWARNING: This script might fail if you mounted or touched an attached disk, only do the strict necessary before running this script.\e[0m"
read -rp "Type DOIT to continue: " CONFIRM

[[ "$CONFIRM" != "DOIT" ]] && { echo "Aborted" ; exit 1; }

# Prevent the script from being run multiple times.
touch "$LOCKFILE"


### Installation script

# Wipe disk
echo -e "\e[32mWiping disk...\e[0m"
swapoff -a
sgdisk --zap-all "$DISK"

# Partition disk
echo -e "\e[32mPartitioning disk...\e[0m"
sgdisk -n "$EFI":0:"$BOOTSIZE" -t "$EFI":ef00 -c "$EFI":"EFI" "$DISK"
sgdisk -n "$SWAP":0:"$SWAPSIZE" -t "$SWAP":8200 -c "$SWAP":"swap" "$DISK"
sgdisk -n "$ROOT":0:"$ROOTSIZE" -t "$ROOT":8300 -c "$ROOT":"root" "$DISK"
sgdisk -n "$HOM":0:"$HOMESIZE" -t "$HOM":8300 -c "$HOM":"home" "$DISK"
partprobe "$DISK" && udevadm settle # Ensure updated
sleep 1

# Format partitions
echo -e "\e[32mFormatting disk...\e[0m"
mkfs.fat -F 32 "$EFIPART"
mkswap "$SWAPPART"
mkfs.ext4 -F "$ROOTPART"
mkfs.ext4 -F "$HOMEPART"

# Mount the partitions
echo -e "\e[32mMounting disk...\e[0m"
mount --mkdir "$ROOTPART" /mnt
swapon "$SWAPPART"
mount -o fmask=0137,dmask=0027 --mkdir "$EFIPART" /mnt/boot # Restrict access to root.
mount --mkdir "$HOMEPART" /mnt/home

# Setup mirrors
echo -e "\e[32mGenerating mirrors...\e[0m"
timedatectl
reflector --latest 20 --protocol https --sort rate --country 'CA,US' --save /etc/pacman.d/mirrorlist

# Pacstrap
echo -e "\e[32mRunning pacstrap...\e[0m"
pacstrap -K /mnt base base-devel linux linux-lts linux-firmware amd-ucode sudo git vim man-db man-pages texinfo iwd e2fsprogs dosfstools whois zsh openssh ansible-core

# Fstab
echo -e "\e[32mRunning genfstab...\e[0m"
genfstab -U /mnt >> /mnt/etc/fstab

ROOTPARTUUID=$(blkid -s PARTUUID -o value "${ROOTPART}")
arch-chroot /mnt /bin/bash -s "$ROOTPARTUUID" < "${SCRIPTDIR}/post_chroot.sh"
