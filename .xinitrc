#!/bin/sh
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xset s noblank; xset s 900 0; xset dpms 0 0 0; xset -dpms; xset b off
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
hub-script set-wallpaper restore
xss-lock -- betterlockscreen -l dimblur -- --composite &
# exec cinnamon-session
# exec startxfce4
exec dbus-launch --exit-with-session dusk
# exec dbus-launch --exit-with-session bspwm
# exec dbus-launch --exit-with-session awesome
