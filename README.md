# 🏔️ Hyprland + NVIDIA Dotfiles

Welcome to my clean, modular Arch Linux environment configuration! This repository manages my system package lists, desktop environment settings, and application shortcuts using standard Git and symbolic links.

## 🖥️ System Specs
* **OS:** Arch Linux
* **CPU:** AMD Ryzen
* **GPU:** NVIDIA (Wayland Optimized)
* **WM:** Hyprland
* **Terminal:** Ghostty

---

## 📂 Repository Structure
* `hypr/` - Hyprland window manager configurations (includes NVIDIA variables)
* `waybar/` - Status bar layout and CSS styling
* `rofi/` - Application launcher menus
* `ghostty/` - Terminal emulator themes and settings
* `pkglists/` - Text exports of official, AUR, Flatpak, and Snap packages
* `scripts/` - Automated synchronization and installation tools

---

## 🚀 How to Install / Deploy (For Friends & New Setups)

### 1. Clone the Repository
```bash
git clone https://github.com ~/Git/dotfiles_config
cd ~/Git/dotfiles_config
```

### 2. Run the Deployment Script
This script automatically maps the configuration folders from this repository directly to your local `~/.config` folder using symbolic links:
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

### 3. Install the System Packages
First, ensure you have an AUR helper like `yay` installed. Then feed the package lists back into your package managers:

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

---

## 🟢 Critical Setup: NVIDIA + Wayland Control Commands
Because this setup runs **Hyprland on an NVIDIA GPU**, you **must** execute these kernel and driver configuration commands on a fresh install before booting into the graphical interface. Failure to do so will result in a black screen or heavy stuttering.

### 1. Install the Essential Display Drivers
```bash
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils linux-headers eglexternalplatform
```

### 2. Enable Early Kernel Mode Setting (KMS)
Inject the core NVIDIA modules directly into your initial ramdisk configuration layout:
```bash
sudo sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
sudo mkinitcpio -P
```

### 3. Inject Kernel Parameter into GRUB Bootloader
Force Direct Rendering Manager (DRM) modesetting to active:
```bash
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1 /' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
*(Note: If you use systemd-boot instead of GRUB, manually append `nvidia_drm.modeset=1` to your active option line inside `/boot/loader/entries/arch.conf` instead).*

---

## 🛠️ Maintenance & Synchronization Control Commands

### How to Save Your Package Progress
Whenever you install new apps or alter configurations on your daily system, update your package logs inside this repository directory using the synchronization loop tool:
```bash
cd ~/Git/dotfiles_config
./scripts/sync.sh
```

### How to Push Your Local Updates Online
```bash
# Verify your active modifications
git status

# Stage, bundle, and push your changes to your remote instance
git add .
git commit -m "Update system configuration files"
git push origin main
```
