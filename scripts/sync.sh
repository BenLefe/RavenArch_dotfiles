#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../pkglists"

pacman -Qeq > "$DIR/arch-repo.txt"
yay -Qeq --foreign > "$DIR/aur.txt"
flatpak list --app --columns=application > "$DIR/flatpak.txt"
snap list | awk 'NR>1 {print $1}' > "$DIR/snap.txt"

echo "Package lists updated successfully in dotfiles/pkglists/!"
