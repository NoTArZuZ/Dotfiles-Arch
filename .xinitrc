#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setterm --blank=0 --powersave off --powerdown=0; xset s 0 0; xset dpms 0 0 0; xset s off; xset s noblank; xset -dpms
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
~/Scripts/set-wallpaper restore
# exec cinnamon-session
# exec startxfce4 # disable dunst and install xfce4-notifyd
exec dusk; pkill slstatus
# exec dbus-launch --exit-with-session bspwm
# exec dbus-launch --exit-with-session awesome
