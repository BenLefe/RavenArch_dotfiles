#!/bin/bash
DOTDIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)/.."
mkdir -p ~/.config

echo "🔗 Creating system symlinks..."
ln -sfn "$DOTDIR/hypr" ~/.config/hypr
ln -sfn "$DOTDIR/waybar" ~/.config/waybar
ln -sfn "$DOTDIR/rofi" ~/.config/rofi
ln -sfn "$DOTDIR/ghostty" ~/.config/ghostty

echo "🔐 Deploying RavenArch SDDM Login Layout..."
if [ -d "$DOTDIR/sddm" ]; then
    sudo mkdir -p /etc/sddm.conf.d/
    sudo cp -rf "$DOTDIR/sddm/"* /etc/sddm.conf.d/ 2>/dev/null || true
    echo "SDDM settings applied successfully!"
fi

echo "✅ UI configuration symlinks dropped successfully!"
echo "💡 To configure your terminal shell layout, check out the instructions inside the oh-my-bash/ directory."
