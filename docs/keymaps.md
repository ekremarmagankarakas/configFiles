# Keymaps Reference

Complete keybinding reference across all tools. For Neovim-specific keymaps, see also [`nvim/keymaps.md`](../nvim/keymaps.md) for the full vim motions cheatsheet.

---

## Neovim

Neovim keymaps live here: [`nvim/keymaps.md`](../nvim/keymaps.md).

---

## Tmux

**Prefix:** `Ctrl-s`

| Key | Action |
|-----|--------|
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + c` | New window |
| `prefix + 1-9` | Switch window |
| `prefix + %` | Vertical split |
| `prefix + "` | Horizontal split |
| `prefix + z` | Zoom pane |
| `prefix + d` | Detach |
| `prefix + r` | Reload config |
| `prefix + I` | Install plugins (TPM) |
| `prefix + [` | Enter copy mode (vi keys) |

---

## Zsh (Vi Mode)

| Key | Mode | Action |
|-----|------|--------|
| `Esc` | insert | Enter normal mode |
| `j` / `k` | normal | History prefix search |
| `v` | normal | Edit command in $EDITOR |
| `/` / `?` | normal | Search history |
| `h/j/k/l` | menu | Navigate completion menu |
| `Ctrl-r` | insert | Reverse history search |
| `Ctrl-a` / `Ctrl-e` | insert | Beginning / end of line |
| `Alt-y` | insert | Accept autosuggestion |

---

## Window Managers

### AeroSpace (macOS) -- Modifier: `Alt`

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus |
| `Alt + Shift + h/j/k/l` | Move window |
| `Alt + 1-0` | Workspace |
| `Alt + f` | Fullscreen |
| `Alt + Enter` | Kitty |
| `Alt + r` | Resize mode |

### i3 (Linux) -- Modifier: `Super`

| Key | Action |
|-----|--------|
| `Super + h/j/k/l` | Focus |
| `Super + Shift + h/j/k/l` | Move window |
| `Super + 1-0` | Workspace 1-10 |
| `Super + Alt + 1-0` | Workspace 11-20 |
| `Super + f` | Fullscreen |
| `Super + Return` | Kitty |
| `Super + d` | Rofi launcher |
| `Super + r` | Resize mode |
