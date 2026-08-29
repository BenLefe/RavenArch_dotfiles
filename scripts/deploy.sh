#!/bin/bash
DOTDIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)/.."
mkdir -p ~/.config

echo "Creating symlinks for Hyprland setup..."
ln -sfn "$DOTDIR/hypr" ~/.config/hypr
ln -sfn "$DOTDIR/waybar" ~/.config/waybar
ln -sfn "$DOTDIR/rofi" ~/.config/rofi
ln -sfn "$DOTDIR/ghostty" ~/.config/ghostty

echo "Symlinks created! Ready to customize or run package installations."
