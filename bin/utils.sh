#!/usr/bin/bash

countdown() {
  date1=$(($(date +%s) + $1));
  while [ "$date1" -ne   "$(date +%s)"  ]; do
    echo -ne "$(date -u --date @$((date1 - $(date +%s))) +%H:%M:%S)\r";
    sleep 0.1
  done


  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*) machine=Linux;;
    Darwin*) machine=Mac;;
    *) machine="UNKNOWN:${unameOut}"
  esac

  if [[ $machine == Mac ]]; then
    # if macos
    osascript -e 'display notification "test2" with title "test"'
    afplay ~/sounds/bell-ringing-04.wav
  elif [[ $machine == Linux ]]; then
    notify-send "time is up!" "$message"
    play ~/music/sounds/bell-ringing-04.wav
  else
    echo "machine not recognized: $machine"
  fi
}
# for arch scripts, will need to export:
# export -f countdown
