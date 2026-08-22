# Window Management

## Overview

| Platform | Window Manager | Modifier Key |
|----------|---------------|--------------|
| macOS | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | `Alt` |
| Linux | [i3](https://i3wm.org/) | `Alt` (Mod1) |

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
| `Alt + Enter` | Open Ghostty terminal |
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

Workspaces 1-4 are pinned to the main monitor. Workspace 5 prefers the second external monitor (falls back to main). Workspaces 6-10 prefer the first external monitor, then the second, falling back to main.

---

## i3 (Linux)

Config: [`i3/config`](../i3/config)

### Keybindings

`$mod` is set to `Mod1` (Alt) in `i3/config`, not Super/Mod4.

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus left/down/up/right |
| `Alt + Shift + h/j/k/l` | Move window left/down/up/right |
| `Alt + 1-9, 0` | Switch to workspace 1-10 |
| `Alt + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Alt + f` | Toggle fullscreen |
| `Alt + Shift + Space` | Toggle floating |
| `Alt + Space` | Toggle focus between tiling/floating |
| `Alt + s` | Stacking layout |
| `Alt + w` | Tabbed layout |
| `Alt + e` | Toggle split |
| `Alt + Ctrl + h` | Split horizontal |
| `Alt + Ctrl + v` | Split vertical |
| `Alt + r` | Enter resize mode |
| `Alt + Shift + c` | Reload config |
| `Alt + Shift + r` | Restart i3 in-place |
| `Alt + Shift + q` | Kill focused window |
| `Alt + a` | Focus parent container |
| `Alt + Shift + e` | Exit i3 (with confirmation prompt) |

> **Likely bug:** `i3/config` also binds `$mod+Mod1+1-9,0` and `Mod1+Shift+1-9,0` for workspaces 11-20, following the standard i3-config-wizard pattern of "base mod for 1-10, +Alt for 11-20." But since `$mod` is *already* `Mod1`, `$mod+Mod1+N` collapses to the same combo as `$mod+N` — these bindings likely shadow the workspace 1-10 bindings instead of reaching workspaces 11-20. Worth checking in i3 directly (not fixed here since it's a config change, not a doc one).

### Applications

| Key | Action |
|-----|--------|
| `Alt + Return` | Open Kitty terminal |
| `Alt + d` | Rofi: Apps (`drun`) |
| `Alt + p` | Rofi hub (bangs + monitor switcher, see below) |
| `Alt + x` | Rofi: window switcher |
| `Alt + Shift + f` | Thunar (file manager) |
| `Alt + Shift + b` | Firefox |
| `Alt + Shift + x` | Lock screen (i3lock) |
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

| Key | Script arg | Description |
|-----|------------|-------------|
| `Alt + m` | `boston` | Ultrawide 3440x1440 |
| `Alt + i` | `istanbul` | Secondary 2560x1440 via HDMI |
| `Alt + o` | `next` | 4K 3840x2160 |
| `Alt + n` | `laptop` | Internal display only |

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

Rofi is used as the primary launcher on Linux, replacing dmenu. It has vi-style navigation (`Alt+j/k`) and a dark theme matching the i3 color scheme. Four modes are configured in `rofi/config.rasi`: `launcher` (the custom hub script below), `drun`, `window`, `run`.

### Rofi Hub

`Alt + p` (`rofi -show launcher`) runs [`rofi/scripts/launcher`](../rofi/scripts/launcher), a single script that opens with a selectable list of the 4 monitor profiles (see below) plus non-selectable hint lines for every bang command. Typing a bang command directly and pressing Enter runs it immediately — there's no separate "Apps/Bookmarks/Web Search" sub-menu.

### Bang Commands

- `!s <query>` -- DuckDuckGo search
- `!u <url>` -- Open URL in Firefox
- `!b <cmd>` -- Run command in terminal (Kitty, stays open)
- `!e <file>` -- Edit file in Neovim (opens in terminal)
- `!o <path>` -- `xdg-open` a path
- `!calc <expr>` -- Calculator via `bc -l`, copies result to clipboard
- `!note` -- New timestamped note in `~/notes/`, opened in Neovim
- `!wifi on|off` -- Enable/disable WiFi
- `!br <0-100>` -- Screen brightness
- `!kbr <0-100>` -- Keyboard backlight
- `!vol <0-150>|mute` -- Volume
- `!play` / `!pause` / `!next` / `!prev` -- Media controls
- `monitor <boston|istanbul|next|laptop>` -- Switch monitor layout (also reachable as one of the selectable list entries)

Anything not matching a bang falls back to running as a shell command.
