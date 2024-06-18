#!/bin/bash

if [ $(eww get countdownbri) == "0" ]; then
    eww open popup_bri
fi
eww update countdownbri=2

current_brightness=0.00

# Specify the device name
device="intel_backlight"

# Get the current brightness and maximum brightness
current_brightness=$(brightnessctl -d $device g)
max_brightness=$(brightnessctl -d $device m)

# Calculate the percentage
percentage=$((current_brightness * 100 / max_brightness))
 
eww update current_brightness=$percentage
