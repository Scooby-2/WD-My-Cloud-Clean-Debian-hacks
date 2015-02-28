#!/bin/bash
# Script to flash disk led when in standby
flash() { for c in {1..30}; do echo off > "$led"; sleep 1; echo green > "$led"; sleep 1; done; }
steady() { echo green > "$led"; sleep 60; }
led="/sys/class/leds/system_led/color"
hdparm -S 242 /dev/sda >/dev/null 2>&1 # 1 hour on a WD RED drive, model WD20EFRX
while :
do
state="$(hdparm -C /dev/sda|grep state|awk '{print $4}')"
[[ "$state" == "active/idle" ]] && steady
[[ "$state" == "standby" ]] && flash
done
