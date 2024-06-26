#!/usr/bin/env bash

# #!/usr/usr/bin/env bash

countdown() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*) machine=Linux ;;
    Darwin*) machine=Mac ;;
    *) machine="UNKNOWN:${unameOut}" ;;
  esac

  date1=$(($(date +%s) + $1))
  while [ "$date1" -ne "$(date +%s)" ]; do
    # print out the current time (this is OS-specific)
    if [[ $machine == Mac ]]; then
      echo -ne "$(date -u -r $((date1 - $(date +%s))) +%H:%M:%S)\r"
    elif [[ $machine == Linux ]]; then
      echo -ne "$(date -u --date @$((date1 - $(date +%s))) +%H:%M:%S)\r"
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
    afplay ~/sounds/timer_ring.mp3
  elif [[ $machine == Linux ]]; then
    notify-send "time is up!" "$MESSAGE"
    play ~/sounds/timer_ring.mp3
  fi
}
# for arch scripts, will need to export:
# export -f countdown

# remove color escape sequences from a terminal output.
alias color-filter="sed -r 's/\x1b\[[0-9;]*m//g'"
