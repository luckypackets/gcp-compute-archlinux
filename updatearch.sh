#!/bin/bash
mv /etc/pacman.conf /etc/pacman.conf.old
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
curl -o /etc/pacman.conf https://github.com/luckypackets/gcp-compute-archlinux/blob/81757ec3a26900347e080279e69821fdbf196169/pacman.conf
curl -o /etc/pacman.d/mirrorlist https://github.com/luckypackets/gcp-compute-archlinux/blob/81757ec3a26900347e080279e69821fdbf196169/mirrorlist
pacman -Syy
pacman -S archlinux-keyring
pacman-key --refresh-keys
