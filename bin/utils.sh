#!/bin/bash

# #!/usr/bin/bash

countdown() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*) machine=Linux;;
    Darwin*) machine=Mac;;
    *) machine="UNKNOWN:${unameOut}"
  esac

  date1=$(($(date +%s) + $1));
  while [ "$date1" -ne   "$(date +%s)"  ]; do
    # print out the current time (this is OS-specific)
    if [[ $machine == Mac ]]; then
      echo -ne "$(date -u -r $((date1 - $(date +%s))) +%H:%M:%S)\r";
    elif [[ $machine == Linux ]]; then
      echo -ne "$(date -u --date @$((date1 - $(date +%s))) +%H:%M:%S)\r";
    else
      echo "machine not recognized: $machine"
      exit 1
    fi
    sleep 0.1
  done

  MESSAGE=$2
  if [[ $machine == Mac ]]; then
    # osascript -e "display notification "$1" with title "$1"'
    osascript -e "display notification \"(Timer is up)\" with title \"$MESSAGE\""
    afplay ~/sounds/bell-ringing-04.wav
  elif [[ $machine == Linux ]]; then
    notify-send "time is up!" "$MESSAGE"
    play ~/music/sounds/bell-ringing-04.wav
  fi
}
# for arch scripts, will need to export:
# export -f countdown
