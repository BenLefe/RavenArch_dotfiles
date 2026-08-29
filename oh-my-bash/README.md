# 🐚 Oh My Bash Setup Guide

To get the beautiful terminal layouts and prompt decorations used in this desktop setup, follow these simple steps.

## 📥 1. Automatic Installation
Run the official terminal installation script:
```bash
bash -c "\$(curl -fsSL https://githubusercontent.com)"
```

## 🎨 2. Set the Custom Layout Theme
Once the installation finishes, it will generate a clean `~/.bashrc` file. 

1. Open your bash configuration file:
   ```bash
   nano ~/.bashrc
   ```
2. Find the line that starts with `OSH_THEME=` and change it to match my exact setup:
   ```bash
   OSH_THEME="cupcake"
   ```
3. Save the file (`Ctrl+O`, `Enter`, `Ctrl+X`) and reload your terminal layout engine:
   ```bash
   source ~/.bashrc
   ```
