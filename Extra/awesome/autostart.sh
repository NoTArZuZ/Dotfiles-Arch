#!/usr/bin/env bash

pgrep -x picom > /dev/null || picom --vsync -b &

xrdb -merge ~/.Xresources
feh --bg-scale ~/.cache/wallcache
