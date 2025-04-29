#!/bin/bash

# Stop picom
killall picom

# Wait for 5 seconds (you take your screenshot manually during this time)
sleep 5

# Restart picom
picom --config ~/.config/picom/picom.conf &

