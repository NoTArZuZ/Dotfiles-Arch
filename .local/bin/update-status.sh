#!/usr/bin/env bash

for pid in $(pidof -x "update-status.sh"); do
  if [ $pid != $$ ]; then
    echo "$(date +"%F %T"): status_updater.sh is already running with PID $pid, killing"
    kill $pid
  fi
done

sleep 0.5

SETSTATUS="duskc --ignore-reply run_command setstatus"

secs=0

while true; do
  $SETSTATUS 0 "$(~/dusk-status/funcs/date)" &
  $SETSTATUS 1 "$(~/dusk-status/funcs/mem)" &
  $SETSTATUS 5 "$(~/dusk-status/funcs/keymap)" &

  if [ $((secs % 3)) = 0 ]; then
    $SETSTATUS 2 "$(~/dusk-status/funcs/cpu)" &
    $SETSTATUS 4 "$(~/dusk-status/funcs/volume)" &
  fi

  if [ $((secs % 60)) = 0 ]; then
    $SETSTATUS 3 "$(~/dusk-status/funcs/diskfree)" &
  fi

  ((secs+=1))
  sleep 1
done
