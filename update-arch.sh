#!/bin/bash

# This script automates the process of updating a stale Arch Linux installation.
# It backs up old pacman configuration, fetches updated files, refreshes keys,
# and performs a full system upgrade.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting Arch Linux Update ---"

# --- 1. Backup old configuration files ---
echo "[1/6] Backing up old pacman.conf and mirrorlist..."
if [ -f /etc/pacman.conf ]; then
    sudo mv /etc/pacman.conf /etc/pacman.conf.old
    echo "      Backed up /etc/pacman.conf to /etc/pacman.conf.old"
else
    echo "      /etc/pacman.conf not found, skipping backup."
fi

if [ -f /etc/pacman.d/mirrorlist ]; then
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
    echo "      Backed up /etc/pacman.d/mirrorlist to /etc/pacman.d/mirrorlist.old"
else
    echo "      /etc/pacman.d/mirrorlist not found, skipping backup."
fi

# --- 2. Download updated pacman.conf and mirrorlist ---
echo "[2/6] Downloading new pacman.conf and mirrorlist..."
sudo curl -o /etc/pacman.conf https://raw.githubusercontent.com/luckypackets/gcp-compute-archlinux/refs/heads/main/pacman.conf
echo "      Downloaded new pacman.conf."
sudo curl -o /etc/pacman.d/mirrorlist https://raw.githubusercontent.com/luckypackets/gcp-compute-archlinux/refs/heads/main/mirrorlist
echo "      Downloaded new mirrorlist."

# --- 3. Synchronize package databases ---
echo "[3/6] Synchronizing package databases..."
sudo pacman -Sy --noconfirm

# --- 4. Install the latest archlinux-keyring package ---
echo "[4/6] Updating archlinux-keyring..."
# We use --noconfirm to automate this step.
# It's often the first package to be updated on a stale system to fix signature issues.
sudo pacman -S --noconfirm archlinux-keyring

# --- 5. Refresh GPG keys ---
echo "[5/6] Refreshing GPG keys..."
sudo pacman-key --refresh-keys

# --- 6. Perform full system upgrade ---
echo "[6/6] Performing full system upgrade (pacman -Syu)..."
# Using --noconfirm to automatically answer 'yes' to prompts.
sudo pacman -Syu --noconfirm

echo "--- Arch Linux Update Complete! ---"
echo "Your system is now up to date."
