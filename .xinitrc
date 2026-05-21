#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xclock="xclock"
xterm="xterm"
twm="twm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    "$xmodmap" "$usermodmap"
fi

# start some nice programs

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#"$twm" &
#"$xclock" -geometry 50x50-1+1 &
#"$xterm" -geometry 80x50+494+51 &
#"$xterm" -geometry 80x20+494-0 &
#exec "$xterm" -geometry 80x66+0+0 -name login

# --- เพิ่มคอนฟิกสำหรับ Chuwi + i3wm เข้าไปตรงนี้ ---

# load .xprofile for env vars (GTK_IM_MODULE, QT_IM_MODULE, XMODIFIERS, etc.)
[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# 1. โหลดค่า DPI จาก .Xresources (ช่วยขยายตัวอักษรบนจอ 10.5 นิ้ว)
if [ -f $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi

# 2. ตั้งค่า keyboard layout us,th โดยไม่มี option (Fcitx5 + script จัดการสลับเอง)
setxkbmap -layout us,th -option &

# 3. หมุนจอ DSI-1 (Chuwi MiniBook X) จาก portrait → landscape
xrandr --output DSI-1 --rotate right &

# 4. touchpad เสริม (virtual trackpad ของ MiniBook)
xinput set-prop "MiniBookSupport Virtual trackpad" "libinput Tapping Enabled" 1 &
xinput set-prop "MiniBookSupport Virtual trackpad" "libinput Tapping Drag Lock Enabled" 1 &

# 6. สั่งรัน i3 window manager (สำคัญที่สุด! ห้ามใส่เครื่องหมาย & ปิดท้ายบรรทัดนี้)
exec i3
