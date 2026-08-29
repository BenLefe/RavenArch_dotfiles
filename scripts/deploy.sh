#!/bin/bash
DOTDIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)/.."
mkdir -p ~/.config

echo "🔗 Creating system symlinks..."
ln -sfn "$DOTDIR/hypr" ~/.config/hypr
ln -sfn "$DOTDIR/waybar" ~/.config/waybar
ln -sfn "$DOTDIR/rofi" ~/.config/rofi
ln -sfn "$DOTDIR/ghostty" ~/.config/ghostty

echo "✅ UI configuration symlinks dropped successfully!"
echo "💡 To configure your terminal shell layout, check out the instructions inside the oh-my-bash/ directory."

