#!/bin/bash

# Detect connected monitors
CONNECTED=$(xrandr | grep " connected" | awk '{print $1}')

# Check for specific monitor signatures
if echo "$CONNECTED" | grep -q "DP-1-0" && echo "$CONNECTED" | grep -q "eDP-1"; then
    # Boston setup detected
    ~/.config/i3/scripts/monitor-setup.sh boston
elif echo "$CONNECTED" | grep -q "HDMI-1-0" && echo "$CONNECTED" | grep -q "eDP"; then
    # Istanbul setup detected
    ~/.config/i3/scripts/monitor-setup.sh istanbul
elif echo "$CONNECTED" | grep -q "DP-1-0.5" && echo "$CONNECTED" | grep -q "eDP"; then
    # NeXT setup detected
    ~/.config/i3/scripts/monitor-setup.sh next
else
    # Laptop only
    ~/.config/i3/scripts/monitor-setup.sh laptop
fi
