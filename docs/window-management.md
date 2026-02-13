# Window Management

## Overview

| Platform | Window Manager | Modifier Key |
|----------|---------------|--------------|
| macOS | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | `Alt` |
| Linux | [i3](https://i3wm.org/) | `Super` (Mod4) |

Both use the same mental model: vi-style focus, workspace numbers 1-10, and a resize mode.

---

## AeroSpace (macOS)

Config: [`aerospace/aerospace.toml`](../aerospace/aerospace.toml)

### Keybindings

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus left/down/up/right |
| `Alt + Shift + h/j/k/l` | Move window left/down/up/right |
| `Alt + 1-9, 0` | Switch to workspace 1-10 |
| `Alt + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Alt + f` | Toggle fullscreen |
| `Alt + Shift + Space` | Toggle floating/tiling |
| `Alt + s` | Vertical accordion (stacking) |
| `Alt + w` | Horizontal accordion (tabbed) |
| `Alt + e` | Toggle split direction |
| `Alt + Shift + ;` | Split horizontal |
| `Alt + Shift + v` | Split vertical |
| `Alt + r` | Enter resize mode |
| `Alt + Shift + c` | Reload config |

### Quick Launch

| Key | Action |
|-----|--------|
| `Alt + Enter` | Open Kitty terminal |
| `Alt + b` | Open Brave Browser |
| `Alt + Shift + f` | Open Commander One (file manager) |

### Resize Mode

| Key | Action |
|-----|--------|
| `h` | Shrink width |
| `l` | Grow width |
| `j` | Grow height |
| `k` | Shrink height |
| `Enter` | Exit resize mode |

### Gaps

- Inner: 10px horizontal, 10px vertical
- Outer: 5px on all sides

### Multi-Monitor

Workspaces 1-5 are assigned to the main monitor. Workspaces 6-9 are assigned to the secondary monitor (falling back to main if no secondary is connected).

---

## i3 (Linux)

Config: [`i3/config`](../i3/config)

### Keybindings

| Key | Action |
|-----|--------|
| `Super + h/j/k/l` | Focus left/down/up/right |
| `Super + Shift + h/j/k/l` | Move window left/down/up/right |
| `Super + 1-9, 0` | Switch to workspace 1-10 |
| `Super + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Super + Alt + 1-9, 0` | Switch to workspace 11-20 |
| `Alt + Shift + 1-9, 0` | Move window to workspace 11-20 |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle floating |
| `Super + Space` | Toggle focus between tiling/floating |
| `Super + s` | Stacking layout |
| `Super + w` | Tabbed layout |
| `Super + e` | Toggle split |
| `Super + Ctrl + h` | Split horizontal |
| `Super + Ctrl + v` | Split vertical |
| `Super + r` | Enter resize mode |
| `Super + Shift + c` | Reload config |
| `Super + Shift + r` | Restart i3 in-place |

### Applications

| Key | Action |
|-----|--------|
| `Super + Return` | Open Kitty terminal |
| `Super + d` | Rofi hub (launcher menu) |
| `Super + x` | Rofi run |
| `Super + Shift + f` | Thunar (file manager) |
| `Super + Shift + b` | Zen Browser |
| `Super + Shift + x` | Lock screen (i3lock) |
| `Print` | Screenshot (maim + xclip) |

### Media Keys

| Key | Action |
|-----|--------|
| `XF86AudioPlay/Pause` | Play/Pause (playerctl) |
| `XF86AudioNext/Prev` | Next/Previous track |
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp` | Brightness up 5% |
| `XF86MonBrightnessDown` | Brightness down 5% |

### Multi-Monitor

20 workspaces total: 1-10 on the primary monitor, 11-20 on the secondary.

Monitor profiles are available via keybindings or the Rofi monitor selector:

| Key | Profile | Description |
|-----|---------|-------------|
| `Super + m` | Profile 1 | Ultrawide 3440x1440 |
| `Super + i` | Profile 2 | Secondary 2560x1440 via HDMI |
| `Super + o` | Profile 3 | 4K 3840x2160 |
| `Super + n` | Laptop | Internal display only |

### Appearance

- Border: 0px (borderless windows)
- Gaps: 10px inner, 0px outer
- Colors: dark background (`#111210`), white text (`#f3f4f5`)
- Status bar: i3blocks at the top (volume, disk, battery, time)
- Wallpaper: set via `feh`
- Caps Lock remapped to Escape via `setxkbmap`

---

## Rofi (Linux Application Launcher)

Config: [`rofi/config.rasi`](../rofi/config.rasi)

Rofi is used as the primary launcher on Linux, replacing dmenu. It has vi-style navigation (`Alt+j/k`) and a dark theme matching the i3 color scheme.

### Rofi Hub

The main entry point (`Super + d`) opens a menu with these options:

| Option | Description |
|--------|-------------|
| Apps | Standard application launcher |
| Bookmarks | Open surfraw bookmarks |
| Web Search | Search the web via surfraw engines |
| Monitor Setup | Select monitor profile |
| Bangs | DuckDuckGo-style bang commands |

### Bang Commands

The bangs system provides quick access to common actions:

- `!ddg <query>` -- DuckDuckGo search
- `!url <url>` -- Open URL
- `!term <cmd>` -- Run command in terminal
- `!calc <expr>` -- Calculator
- `!tmux <name>` -- Create/attach tmux session
- `!note <text>` -- Quick note
- `!wifi` -- Toggle WiFi
- Media controls, brightness, volume, keyboard backlight

---

## Karabiner-Elements (macOS)

Config: [`karabiner/karabiner.json`](../karabiner/karabiner.json)

Key remappings:

| From | To |
|------|----|
| Caps Lock (tap) | Escape |
| Caps Lock (hold) | Caps Lock |
| Fn | Left Control |
| Left Control | Fn |
