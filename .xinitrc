#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setterm --blank=0 --powersave off --powerdown=0; xset s 0 0; xset dpms 0 0 0; xset s off; xset s noblank; xset -dpms &
xsetroot -cursor_name left_ptr &
xrdb -merge /home/sus/.Xresources &
feh --bg-scale ~/.cache/wallcache
exec dbus-launch --sh-syntax --exit-with-session dusk
