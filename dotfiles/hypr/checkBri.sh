#!/bin/bash

while [ true ]; do
    case $(eww get countdownbri) in
        "3")
            eww update countdownbri="2"
        ;;

        "2")
            eww update countdownbri="1"
        ;;

        "1")
            eww update countdownbri="0"
            eww close popup_bri
        ;;
    esac
    sleep 1
done
