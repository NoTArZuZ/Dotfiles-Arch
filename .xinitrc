#!/bin/sh
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setterm --blank=0 --powersave off --powerdown=0; xset s 0 0; xset dpms 0 0 0; xset s off; xset s noblank; xset -dpms
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
hub-script set-wallpaper restore
~/.local/bin/mpd-cover notification &
udiskie --tray &
# exec cinnamon-session
# exec startxfce4
exec dbus-launch --exit-with-session dusk
# exec dbus-launch --exit-with-session bspwm
# exec dbus-launch --exit-with-session awesome
