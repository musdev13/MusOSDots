#!/bin/bash

apps=$(adb shell pm list packages -3 | cut -d: -f2)
mapfile -t packages <<< "$apps"

for i in "${!packages[@]}"; do
    index=$((i + 1))
    echo "$index) ${packages[$i]}"
done

echo -ne "\n> "
read -r num

if [[ "$num" -lt 1 || "$num" -gt "${#packages[@]}" ]]; then
    exit 1
fi

chosen_pkg="${packages[$((num - 1))]}"
scrcpy -K --new-display=720x1280 --crop=720:1200:0:0 --video-bit-rate 2M --max-fps 60 --video-codec=h264 --video-encoder=c2.qti.avc.encoder --start-app="$chosen_pkg"

read -n 1 -s -r -p

