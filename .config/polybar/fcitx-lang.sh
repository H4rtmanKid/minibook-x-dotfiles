#!/bin/bash
im=$(fcitx5-remote -n 2>/dev/null)
case "$im" in
    keyboard-th) echo "TH" ;;
    *)           echo "EN" ;;
esac
