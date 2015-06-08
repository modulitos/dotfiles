#!/bin/bash
B_ROOT="/sys/class/backlight/intel_backlight"
V1="/brightness"
V2="/max_brightness"

BCURR=$(cat "$B_ROOT$V1")
BMAX=$(cat "$B_ROOT$V2")

case "$1" in 
  chmod)
    sudo chmod 666 "$B_ROOT$V1"
    ;;
  conkyread)
    printf "B%s%%" $((BCURR*100/BMAX))
    ;;
  read)
    printf "%-47s %-6s (%-3s%%) \n" "$B_ROOT$V1" $BCURR $((BCURR*100/BMAX))
    ;;
  add)
    [ $# -ne 2  ] && exit 1
    BNEW=$(($2 + $BCURR))
    [ $BNEW -gt $BMAX  ] && BNEW=$BMAX
    [ $BNEW -lt 100  ] && BNEW=100
    echo $BNEW > "$B_ROOT$V1"
    ;;
esac
