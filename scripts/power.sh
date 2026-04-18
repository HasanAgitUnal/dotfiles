#!/bin/bash
ACTION=$1

case $ACTION in
    lock) 
        hyprlock 
        ;;
    sleep) 
        hyprlock & 
        systemctl suspend 
        ;;
    logout) 
        sleep 0.4 && hyprctl dispatch exit 
        ;;
    reboot) 
        sleep 0.4 && reboot 
        ;;
    shutdown) 
        sleep 0.4 && shutdown now 
        ;;
esac
