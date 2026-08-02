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
| `prefix + J` | Pull pane from another window (prompts `window.pane`) |
| `prefix + S` | Send current pane to another window (prompts number) |
| `prefix + B` | Break current pane into its own window |

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

### Zoxide

| Command | Action |
|---------|--------|
| `z <name>` | Jump to most frecent matching directory |
| `zi` | Interactive fuzzy directory picker |

---

## Window Managers

### AeroSpace (macOS) -- Modifier: `Alt`

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus |
| `Alt + Shift + h/j/k/l` | Move window |
| `Alt + 1-0` | Workspace |
| `Alt + f` | Fullscreen |
| `Alt + Enter` | Open Ghostty terminal |
| `Alt + b` | Open Brave Browser |
| `Alt + Shift + f` | Open Commander One |
| `Alt + r` | Resize mode |

### i3 (Linux) -- Modifier: `Alt` (Mod1, not Super — see [`window-management.md`](window-management.md))

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus |
| `Alt + Shift + h/j/k/l` | Move window |
| `Alt + 1-0` | Workspace 1-10 |
| `Alt + f` | Fullscreen |
| `Alt + Return` | Kitty |
| `Alt + d` | Rofi: Apps (`drun`) |
| `Alt + p` | Rofi hub (bangs + monitor switcher) |
| `Alt + r` | Resize mode |
