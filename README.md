# 🏔️ Hyprland + NVIDIA Dotfiles

Welcome to my modular and highly aesthetic Arch Linux desktop environment configuration! This repository manages my window manager layouts, system package lists, and terminal settings cleanly using symbolic links.

## 🖥️ System Specs
* **OS:** Arch Linux (Deployed via `archinstall`)
* **CPU:** AMD Ryzen
* **GPU:** NVIDIA (Wayland Optimized)
* **WM:** Hyprland (Dark Purple Theme)
* **Terminal:** Ghostty

---

## 📂 Repository Structure
* `hypr/` - Hyprland window manager configurations (includes NVIDIA Wayland variables)
* `waybar/` - Custom status bar layout and matching purple CSS styling
* `rofi/` - Future-proof application launcher configs and layout assets
* `ghostty/` - Premium terminal configuration profiles and custom color palettes
* `pkglists/` - Text exports of official, AUR, Flatpak, and Snap packages
* `oh-my-bash/` - Simple guide to replicating my terminal prompt layout
* `scripts/` - Automated synchronization and installation utilities

---

## 🚀 How to Install / Deploy (For Friends & New Setups)

### 1. Base Installation Tip
When installing Arch Linux using `archinstall`, ensure you select the **NVIDIA Proprietary Driver** option in the graphics profile menu. This ensures your kernel hooks (`mkinitcpio`) and bootloader parameters are generated automatically!

### 2. Clone the Repository
Once booted into your fresh Arch system, clone this tracking folder:
```bash
git clone https://github.com ~/Git/dotfiles_config
cd ~/Git/dotfiles_config
```

### 3. Link Your Interface
Run the deployment tool script to automatically tie the configuration folders from this repository directly to your system's local `~/.config/` profile via symbolic links:
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

### 4. Restore All System Packages
Ensure you have an AUR helper like `yay` compiled. Then execute these tracking streams to pull all applications back onto your environment:

```bash
# 1. Install Arch Official Packages
sudo pacman -S --needed - < pkglists/arch-repo.txt

# 2. Install AUR Packages
yay -S --needed - < pkglists/aur.txt

# 3. Install Flatpaks
xargs flatpak install -y < pkglists/flatpak.txt

# 4. Install Snaps
sudo systemctl enable --now snapd.socket
xargs -I {} sudo snap install {}
```

*(Note: For your terminal shell prompt theme, navigate into the `oh-my-bash/` folder and read the quick manual provided there.)*
