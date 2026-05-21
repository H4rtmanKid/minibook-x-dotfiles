# Chuwi MiniBook X Dotfiles

Personal dotfiles for Arch Linux on **Chuwi MiniBook X** (Intel Alder Lake-N, 10.5" rotated display)

## Setup

| Component | Program |
|-----------|---------|
| WM | i3-wm |
| Compositor | picom (glx backend) |
| Bar | Polybar |
| Terminal | Alacritty |
| Launcher | Rofi |
| File Manager | Thunar |
| Notification | Dunst |
| Input Method | Fcitx5 (Thai/EN) |
| Screen Lock | i3lock-color + xautolock |
| Screenshot | Flameshot |
| Audio | Pipewire |
| Theme | Orchis-Dark-Dracula |
| Icons | Tela-circle-dracula-dark |
| Font | JetBrainsMono Nerd Font, Sarabun |

## Clean Install

### 1. ติดตั้ง packages

```bash
sudo pacman -S --needed \
  i3-wm i3status picom polybar rofi dunst alacritty \
  thunar gvfs \
  pipewire pipewire-pulse wireplumber pavucontrol \
  networkmanager network-manager-applet \
  bluez bluez-utils blueman \
  fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool \
  i3lock-color xss-lock xautolock \
  flameshot xclip \
  feh arandr \
  polkit-gnome \
  tlp \
  noto-fonts noto-fonts-emoji noto-fonts-cjk \
  ttf-jetbrains-mono-nerd \
  xdg-desktop-portal xdg-desktop-portal-gtk \
  dex xorg-xrandr xinput \
  git
```

> AUR: `orchis-theme-dracula` `tela-circle-icon-theme-dracula` `ttf-sarabun`

### 2. Clone dotfiles

```bash
git clone --bare git@github.com-minixdot:H4rtmanKid/minibook-x-dotfiles.git ~/.dotfiles
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dots config status.showUntrackedFiles no
dots checkout
```

> หากมีไฟล์ default อยู่แล้วให้ backup ก่อน: `mkdir -p ~/.backup && dots checkout 2>&1 | grep "^\s" | awk '{print $1}' | xargs -I{} mv {} ~/.backup/{}`

### 3. Enable services

```bash
sudo systemctl enable --now NetworkManager tlp bluetooth
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

### 4. Reboot แล้ว startx

```bash
reboot
# หลัง login
startx
```

## หมายเหตุเฉพาะเครื่อง

- **จอหมุน**: DSI-1 rotate right (portrait panel → landscape) ตั้งค่าใน `.xinitrc`
- **GTK file dialog**: i3 resize+center fix เพราะ `Xft.dpi=144` ทำให้ dialog ใหญ่กว่าหน้าจอ
- **fcitx5**: ใช้ `keyboard-th` built-in, สลับ Thai/EN ด้วย `Super+Space`
- **picom**: glx backend, xrender มีปัญหากับ Intel Alder Lake-N

## Keybinds หลัก

| Key | Action |
|-----|--------|
| `Super+Enter` | Terminal (Alacritty) |
| `Super+D` | Rofi launcher |
| `Super+Space` | สลับ Thai/EN |
| `Print` | Screenshot (Flameshot GUI) |
| `Super+Print` | Screenshot เต็มหน้าจอ |
| `Super+Shift+Space` | Toggle floating |
| `Super+F` | Fullscreen |
| `Super+Shift+Q` | ปิด window |
| `Super+Shift+E` | Exit i3 |
