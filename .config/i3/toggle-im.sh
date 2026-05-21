#!/bin/bash
if [ "$(fcitx5-remote)" = "2" ]; then
    fcitx5-remote -c
    setxkbmap -layout us,th -option
else
    fcitx5-remote -o
fi
