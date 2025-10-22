#!/bin/bash

# Auto-detect laptop display name
detect_laptop_display() {
    for display in eDP-1 eDP eDP-0; do
        if xrandr | grep -q "^${display} connected"; then
            echo "$display"
            return 0
        fi
    done
    xrandr | grep "^eDP" | grep "connected" | head -1 | awk '{print $1}' || echo "eDP-1"
}

set_workspaces() {
    local primary="$1"
    local secondary="$2"
    
    # Update i3 config with new monitor assignments
    sed -i "s/^set \$fm .*/set \$fm $primary/" ~/.config/i3/config
    sed -i "s/^set \$sm .*/set \$sm $secondary/" ~/.config/i3/config
    
    # Move workspaces to correct monitors (suppress errors for non-existent workspaces)
    for ws in {1..10}; do
        i3-msg "[workspace=\"$ws\"] move workspace to output $primary" &>/dev/null
    done
    
    for ws in {11..20}; do
        i3-msg "[workspace=\"$ws\"] move workspace to output $secondary" &>/dev/null
    done
    
    # Reload i3 to apply changes
    i3-msg reload &>/dev/null
    
    notify-send "Monitor Setup" "✓ $primary (main) + $secondary (laptop)" 2>/dev/null
}

# Detect laptop display
LAPTOP_DISPLAY=$(detect_laptop_display)

# Get list of currently connected outputs to avoid xrandr warnings
CONNECTED_OUTPUTS=$(xrandr | grep " connected" | awk '{print $1}')

# Helper function to turn off output only if it exists
turn_off_output() {
    local output="$1"
    if echo "$CONNECTED_OUTPUTS" | grep -q "^${output}$"; then
        echo "--output $output --off"
    fi
}

case "$1" in
    boston)
        set_workspaces "DP-1-0" "$LAPTOP_DISPLAY"
        sleep 1

        # Build xrandr command only for connected outputs
        XRANDR_CMD="xrandr --output $LAPTOP_DISPLAY --mode 1920x1080 --rate 360 --pos 0x0 --rotate normal \
                   --output DP-1-0 --primary --mode 3440x1440 --rate 100 --pos 1920x0 --rotate normal"
        
        # Add --off for connected outputs we want to disable
        for output in DisplayPort-1 DisplayPort-2 DisplayPort-3 DisplayPort-4 DisplayPort-5 DP-1-1 DP-1-2 HDMI-1-0; do
            XRANDR_CMD="$XRANDR_CMD $(turn_off_output $output)"
        done
        
        eval "$XRANDR_CMD" 2>/dev/null
        ;;
    
    istanbul)
        set_workspaces "HDMI-1-0" "$LAPTOP_DISPLAY"
        sleep 1

        XRANDR_CMD="xrandr --output $LAPTOP_DISPLAY --primary --mode 1920x1080 --pos 2560x360 --rotate normal \
                   --output HDMI-1-0 --mode 2560x1440 --pos 0x0 --rotate normal"
        
        for output in DisplayPort-0 DisplayPort-1 DisplayPort-2 DisplayPort-3 DisplayPort-4 DP-1-0 DP-1-1 DP-1-2; do
            XRANDR_CMD="$XRANDR_CMD $(turn_off_output $output)"
        done
        
        eval "$XRANDR_CMD" 2>/dev/null
        ;;
    
    next)
        set_workspaces "DP-1-0.5" "$LAPTOP_DISPLAY"
        sleep 1

        XRANDR_CMD="xrandr --output $LAPTOP_DISPLAY --mode 1920x1080 --pos 0x0 --rotate normal \
                   --output DP-1-0.5 --primary --mode 3840x2160 --pos 1920x0 --rotate normal \
                   --output DP-1-0.6 --mode 3840x2160 --pos 5760x0 --rotate normal"
        
        for output in DisplayPort-1 DisplayPort-2 DisplayPort-3 DisplayPort-4 DisplayPort-5 DP-1-0 DP-1-1 DP-1-2 HDMI-1-0; do
            XRANDR_CMD="$XRANDR_CMD $(turn_off_output $output)"
        done
        
        eval "$XRANDR_CMD" 2>/dev/null
        ;;
    
    laptop)
        set_workspaces "$LAPTOP_DISPLAY" "$LAPTOP_DISPLAY"
        sleep 1

        # Turn off all external displays
        XRANDR_CMD="xrandr --output $LAPTOP_DISPLAY --primary --mode 1920x1080 --auto"
        
        # Only turn off outputs that are actually connected
        for output in DisplayPort-0 DisplayPort-1 DisplayPort-2 DisplayPort-3 DisplayPort-4 DisplayPort-5 \
                      DP-1-0 DP-1-0.5 DP-1-0.6 DP-1-1 DP-1-2 HDMI-1-0 HDMI-0; do
            XRANDR_CMD="$XRANDR_CMD $(turn_off_output $output)"
        done
        
        eval "$XRANDR_CMD" 2>/dev/null
        ;;
    
    *)
        echo "Usage: $0 {boston|istanbul|next|laptop}"
        notify-send "Monitor Setup" "Invalid option" -u critical 2>/dev/null
        exit 1
        ;;
esac

# Log the configuration for debugging
echo "[$(date)] ✓ $1 setup | Laptop: $LAPTOP_DISPLAY" >> ~/.cache/monitor-setup.log
