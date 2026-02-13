#!/bin/bash

CHOICE=$(echo -e "Boston Home\nIstanbul Home\nNeXT Config\nLaptop Only" | rofi -dmenu -i -p "Monitor Setup:")

case "$CHOICE" in
    "Boston Home")
        ~/.config/i3/scripts/monitor-setup.sh boston
        ;;
    "Istanbul Home")
        ~/.config/i3/scripts/monitor-setup.sh istanbul
        ;;
    "NeXT Config")
        ~/.config/i3/scripts/monitor-setup.sh next
        ;;
    "Laptop Only")
        ~/.config/i3/scripts/monitor-setup.sh laptop
        ;;
esac
