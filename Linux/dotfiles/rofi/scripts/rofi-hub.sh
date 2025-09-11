#!/usr/bin/env bash
# ~/.config/rofi/scripts/rofi-hub.sh
set -euo pipefail

declare -A LABELS
declare -A COMMANDS

# --- entries ---------------------------------------------------------------
COMMANDS["apps"]="rofi -show drun"
LABELS["apps"]="App launcher (drun)"

COMMANDS["bookmarks"]="$HOME/.config/rofi/scripts/rofi-surfraw-bookmarks.sh"
LABELS["bookmarks"]="Open web bookmarks (surfraw)"

COMMANDS["locate"]="$HOME/.config/rofi/scripts/rofi-locate.sh"
LABELS["locate"]="Search local files"

COMMANDS["websearch"]="$HOME/.config/rofi/scripts/rofi-surfraw-websearch.sh"
LABELS["websearch"]="Surfraw engine picker"

COMMANDS["bangs"]="rofi -show bangs"
LABELS["bangs"]="Bangs (bangs)"

# --- menu + dispatch -------------------------------------------------------
print_menu() {
  for key in "${!LABELS[@]}"; do
    printf "%-12s %s\n" "$key" "${LABELS[$key]}"
  done
}

choice="$(print_menu | sort | rofi -dmenu -i -mesg '>>> launch your collection of rofi scripts' -p 'hub: ')"
[ -z "${choice}" ] && exit 0

key="${choice%% *}"   # first field
cmd="${COMMANDS[$key]:-}"

if [ -n "$cmd" ]; then
  # run detached (avoid chaining rofi instances)
  setsid -f nohup bash -lc "$cmd" >/dev/null 2>&1 &
else
  # allow typing arbitrary commands into the hub (optional)
  setsid -f nohup bash -lc "$choice" >/dev/null 2>&1 &
fi

