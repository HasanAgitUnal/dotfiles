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
        canberra-gtk-play -i desktop-logout & 
        sleep 0.4 && hyprctl dispatch exit 
        ;;
    reboot) 
        canberra-gtk-play -i desktop-logout & 
        sleep 0.4 && reboot 
        ;;
    shutdown) 
        canberra-gtk-play -i desktop-logout & 
        sleep 0.4 && shutdown now 
        ;;
esac
