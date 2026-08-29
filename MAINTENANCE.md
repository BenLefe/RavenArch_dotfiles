# 🛠️ Personal System Maintenance & Cheat Sheet

This file acts as my personal reminder manual for capturing updates, modifying ecosystem files, and handling data pipelines.

---

## 🔄 Daily / Weekly Backup Workflow

### 1. Update Package Progress
Whenever you add new system packages or make tweaks to your configuration windows, sync your setup into this repository by executing your backup script:
```bash
cd ~/Git/dotfiles_config
./scripts/sync.sh
```

### 2. Push Your Local Updates Online
```bash
# Verify your active modifications
git status

# Stage, bundle, and push your changes to your remote instance
git add .
git commit -m "Update system configuration files"
git push origin main
```

---

## 📁 System Cheat Sheet

### Dynamic Environment (Symlinks)
Because we configured symlinks, you can edit configurations directly inside `~/.config/` or `~/Git/dotfiles_config/`. Changes apply instantly to both layouts!

### Non-Git Backups (Wine Prefixes)
Wine applications are too heavy for Git and must be moved manually to external hardware or secure cloud volumes:
```bash
# Location of the default prefix
~/.wine

# Location of localized custom gaming profiles (Bottles / Lutris)
~/.local/share/wineprefixes/
```
