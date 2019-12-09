#!/usr/local/bin/bash
# #!/bin/bash
echo $BASH_VERSION
message=$2
countdown() {
  date1=$((`date +%s` + $1));
  while [ "$date1" -ne `date +%s`  ]; do
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  # notify-send "time is up!" "$message"
  # play ~/music/sounds/bell-ringing-04.wav

  # if macos
  osascript -e 'display notification "test2" with title "test"'
  afplay ~/sounds/bell-ringing-04.wav
}
countdown $1
echo "$message"
