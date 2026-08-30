# 🛠️ RavenArch: Full System Maintenance & Reference Manual

This file serves as my ultimate standalone cheat sheet. It contains every critical terminal command, diagnostic sequence, and recovery loop required to manage, synchronize, and rebuild the RavenArch desktop environment from scratch without external assistance.

---

## 📂 Core Repository Context
* **Local Repo Path:** `~/Git/dotfiles_config`
* **Managed System Targets:** Hyprland, Waybar, Rofi, Ghostty, SDDM, Pacman/AUR lists, Flatpaks, Snaps.

---

## 🔄 1. Daily & Weekly Synchronization Loops

### Update Package Lists & Stage Files
Whenever you install new software or change local configurations, use this exact sequence to update the tracked repository:
```bash
cd ~/Git/dotfiles_config

# 1. Execute the synchronized list generator
./scripts/sync.sh

# 2. Verify what modifications Git detects
git status
```

### Push Local Upgrades Online
```bash
# Stage all changes (new configurations, wallpapers, and package lists)
git add .

# Commit with a meaningful label
git commit -m "Update system configurations: \$(date +'%Y-%m-%d')"

# Upload changes to your live public instance
git push origin main
```

---

## 🔍 2. Verifying & Managing Symlinks

Because the user environment relies heavily on symbolic links, use these diagnostic tools to ensure your system and Git folder are communicating perfectly.

### Verify All Active Symlinks
Run this command to inspect the contents of your configuration folder. Linked files will be highlighted in a distinct color (usually cyan) with a physical arrow `->` pointing directly to your Git folder:
```bash
ls -l ~/.config/
```

### Intentionally Check Specific Links
```bash
# Check Hyprland Link Alignment
ls -ld ~/.config/hypr

# Check Ghostty Link Alignment
ls -ld ~/.config/ghostty

# Check Rofi Link Alignment
ls -ld ~/.config/rofi
```
*Expected Output Shape:* `lrwxrwxrwx ... /home/username/.config/hypr -> /home/username/Git/dotfiles_config/hypr`

### How to Re-Link If a Connection Breaks
If an application stops tracking or a folder gets accidentally decoupled, break and force-rebuild the symbolic shortcut cleanly:
```bash
# Format: ln -sfn [TARGET_REAL_FOLDER] [LINK_NAME_SHORTCUT]
ln -sfn ~/Git/dotfiles_config/hypr ~/.config/hypr
ln -sfn ~/Git/dotfiles_config/waybar ~/.config/waybar
ln -sfn ~/Git/dotfiles_config/rofi ~/.config/rofi
ln -sfn ~/Git/dotfiles_config/ghostty ~/.config/ghostty
```

---

## 🚀 3. Fresh Rebuild & Driver Controls

If rebuilding this system on a brand new drive or a second machine, perform these tasks in this exact order.

### A. Core Driver Provisioning (NVIDIA + AMD)
Since RavenArch runs on an AMD CPU and an NVIDIA GPU, execute these driver modules before attempting to initialize the GUI interface:

```bash
# 1. Install Essential Hardware Modules
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils linux-headers eglexternalplatform

# 2. Inject Early Kernel Mode Setting (KMS)
sudo sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
sudo mkinitcpio -P

# 3. Add DRM parameters to GRUB (Fallback if archinstall skipped it)
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1 /' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
*(Note: If using systemd-boot instead of GRUB, append `nvidia_drm.modeset=1` directly to your active configuration string inside `/boot/loader/entries/arch.conf` instead).*

### B. Authenticate with GitHub CLI
Ensure you can securely pull or pull down changes to your repository without typing credentials repeatedly:
```bash
# Check active state
gh auth status

# Log in using the secure browser loop wizard
gh auth login
```

### C. Run the Deployment Script
```bash
cd ~/Git/dotfiles_config
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

### D. Bulk Install All Packages From Text Exports
```bash
# 1. Native Repositories
sudo pacman -S --needed - < pkglists/arch-repo.txt

# 2. AUR Repositories (Via Yay)
yay -S --needed - < pkglists/aur.txt

# 3. Flatpak Ecosystem
xargs flatpak install -y < pkglists/flatpak.txt

# 4. Snap Ecosystem
sudo systemctl enable --now snapd.socket
xargs -I {} sudo snap install {}
```

---

## 💾 4. Non-Git Application Handlers (Wine & SDDM)

### Wine Environment Transfers
Because Wine prefixes are binary heavy and contain local program licenses, do not commit them to GitHub. Back them up manually to external or cloud volumes:
```bash
# Archive the main prefix
tar -czvf ~/Documents/default_wine_backup.tar.gz ~/.wine

# Restore the prefix to a new system
tar -xzvf /path/to/backup/default_wine_backup.tar.gz -C ~/
```

### Manual Fullscreen Rice Screenshot
If you need a quick, one-time full-screen preview picture generated for the repository layout using Hyprshot:
```bash
sleep 3 && hyprshot -m output -o ~/Git/dotfiles_config/assets/ -f preview.png
```

### SDDM Security Management
SDDM files exist outside the user space. To manually back up or tweak the login theme files:
```bash
# Pull active custom parameters from the system to Git
sudo cp -rf /etc/sddm.conf.d/* ~/Git/dotfiles_config/sddm/ 2>/dev/null || true
```
