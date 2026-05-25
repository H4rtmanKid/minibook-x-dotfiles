#!/bin/sh

# Reset to English before locking (Fcitx5 doesn't work inside i3lock)
fcitx5-remote -s keyboard-us 2>/dev/null  # switch Fcitx5 to English first
fcitx5-remote -c 2>/dev/null              # then deactivate
setxkbmap -layout us -option

alpha='dd'
selection='44475a'
comment='6272a4'
green='50fa7b'
orange='ffb86c'
red='ff5555'
magenta='ff79c6'
blue='6272a4'

XMODIFIERS='' i3lock \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$selection$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue$alpha \
  --line-uses-ring \
  --keyhl-color=$magenta$alpha \
  --bshl-color=$orange$alpha \
  --separator-color=$selection$alpha \
  --verif-color=$green'ff' \
  --wrong-color=$red'ff' \
  --modif-color=$red'ff' \
  --layout-color=$blue'ff' \
  --date-color=$blue'ff' \
  --time-color=$blue'ff' \
  --blur 1 \
  --clock \
  --indicator \
  --time-str="%H:%M:%S" \
  --date-str="%A %e %B %Y" \
  --verif-text="Checking..." \
  --wrong-text="Wrong pswd" \
  --noinput="" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --radius=120 \
  --ring-width=10 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys \
  --time-font="JetBrainsMono Nerd Font" \
  --date-font="JetBrainsMono Nerd Font" \
  --layout-font="JetBrainsMono Nerd Font" \
  --verif-font="JetBrainsMono Nerd Font" \
  --wrong-font="JetBrainsMono Nerd Font" \
  --nofork

# After unlock, restore dual-layout (--nofork blocks until unlocked)
setxkbmap -layout us,th -option
