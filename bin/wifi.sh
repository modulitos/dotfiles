#!/bin/bash

case $1 in
  pass|password)
    cat /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf | grep -i -A 1 "$2" | grep -A 1 "^[[:space:]]\+ssid="
    ;;
  iwscan)
    sudo iw wlp4s0 scan | grep 'SSID\|signal'
    ;;
  wpascan)
    wpa_cli scan && sleep 5 && wpa_cli scan_results
    ;;
  search)
    wpa_cli list_networks | grep -i "$2"
    ;;
  current)
    wpa_cli list_networks | grep CURRENT
    ;;
  *)
    echo "Invalid input."
    echo "Valid inputs are:"
    echo ""
    echo "pass|password <ssid>"
    echo "iwscan"
    echo "wpascan"
    echo "search <ssid>"
    echo "current"
    echo "goodbye!"
    ;;
esac

# sudo iw wlp4s0 scan | grep SSID
# cat /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf | grep -A 2

# while getopts 'abf:v --long a-long,b-long:,v-long::' flag; do
#    echo "${flag}"
# #   case "${flag}" in
# #     a) aflag='true' ;;
# #     b) bflag='true' ;;
# #     f) files="${OPTARG}" ;;
# #     v) verbose='true' ;;
# #     *) error "Unexpected option ${flag}" ;;
# #   esac
# done
