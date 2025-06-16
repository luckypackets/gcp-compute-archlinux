#!/bin/bash
sudo mv /etc/pacman.conf /etc/pacman.conf.old
sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
sudo curl -o /etc/pacman.conf https://raw.githubusercontent.com/luckypackets/gcp-compute-archlinux/refs/heads/main/pacman.conf
sudo curl -o /etc/pacman.d/mirrorlist https://raw.githubusercontent.com/luckypackets/gcp-compute-archlinux/refs/heads/main/mirrorlist
sudo pacman -Syy
sudo pacman -S archlinux-keyring
sudo pacman-key --refresh-keys
