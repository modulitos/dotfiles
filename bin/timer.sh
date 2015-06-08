#!/bin/bash
countdown() {
  date1=$((`date +%s` + $1)); 
  while [ "$date1" -ne `date +%s`  ]; do 
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  ffplay ~/Music/sounds/bell-ringing-04.wav
}
countdown $1
