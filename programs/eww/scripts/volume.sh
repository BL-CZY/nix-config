#!/usr/bin/env bash

current_volume=0.00

#get the result
output=$(brightnessctl g)

#parse the current volume
current_volume=$(echo "$output" | grep -oE '[+-]?[0-9]+([.][0-9]+)?')

echo $current_volume

#if it's 1.00, set it to 100
if [ $(echo $current_volume) == "1.00" ]; then
  final="100"
else
  # Check if the first character is not 0
  if [[ "$current_volume" =~ ^[1-9] ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
    final="100"
  else
    final=$(echo $current_volume | cut -d'.' -f2 | cut -c1-2)
  fi
fi

eww update current_volume=$final
