# Keymaps Reference

Complete keybinding reference across all tools. For Neovim-specific keymaps, see also [`nvim/mac/keymaps.md`](../nvim/mac/keymaps.md) for the full vim motions cheatsheet.

---

## Neovim

**Leader:** `Space` | **Local leader:** `\`

### General

| Key | Mode | Action |
|-----|------|--------|
| `<leader>sp` | n | Toggle spell check |
| `<leader>y` | v | Yank to system clipboard |
| `<leader>x` | v | Cut to system clipboard |
| `<leader>/` | n | Clear search highlight |
| `<leader>v` | n | Vertical split |
| `<leader>hs` | n | Horizontal split |
| `Ctrl-h/j/k/l` | n | Navigate between splits |
| `Alt-j` / `Alt-k` | n | Quickfix next / prev |
| `<leader>t` | n | Open terminal below |
| `Esc` | t | Exit terminal insert mode |
| `<leader>st` | n | Theme picker |
| `<leader>sj` | n | Toggle j/k vs gj/gk |
| `<leader>sr` | n | Search & replace (global) |
| `<leader>sq` | n | Search & replace (quickfix) |

### File Explorer (Neo-tree)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>nn` | n | Reveal current file |
| `<leader>nt` | n | Toggle Neo-tree |

### Find (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Buffers |
| `<leader>fo` | n | Recent files |
| `<leader>fw` | n | Grep word under cursor |
| `<leader>fh` | n | Help tags |
| `<leader>fk` | n | Keymaps |
| `<leader>fc` | n | Commands |
| `<leader>fs` | n | Fuzzy find in buffer |
| `<leader>ft` | n | Treesitter symbols |
| `<leader>fa` | n | Find across project directories |
| `<leader>fT` | n | Find TODO comments |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `<leader>lf` | n | Format file |
| `<leader>ltc` | n | Toggle completion |
| `<leader>lef` | n | Diagnostics float |
| `<leader>lD` | n | Diagnostics list |

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl-p` | i | Previous item |
| `Ctrl-n` | i | Next item |
| `Ctrl-y` | i | Confirm selection |
| `Ctrl-Space` | i | Trigger completion |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Open LazyGit |
| `<leader>gp` | n | Preview hunk |
| `]g` / `[g` | n | Next / prev hunk |
| `<leader>gs` | n/v | Stage hunk |
| `<leader>gr` | n/v | Reset hunk |
| `<leader>gS` | n | Stage buffer |
| `<leader>gR` | n | Reset buffer |
| `<leader>gb` | n | Toggle line blame |
| `<leader>gdo` | n | Open Diffview |
| `<leader>gdc` | n | Close Diffview |
| `<leader>gdh` | n | File history (all) |
| `<leader>gdf` | n | File history (current) |

### Copilot

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gct` | n | Toggle Copilot |
| `Alt-y` | i | Accept suggestion |
| `Alt-]` / `Alt-[` | i | Next / prev suggestion |
| `Ctrl-]` | i | Dismiss suggestion |

### Debug (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>dc` | n | Continue / start |
| `<leader>dn` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step out |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dl` | n | Logpoint |
| `<leader>dh` | n/v | Hover value |
| `<leader>du` | n | Toggle DAP UI |
| `<leader>dq` | n | Terminate |
| `<leader>dtj` | n | Toggle justMyCode |
| `<leader>dtv` | n | Toggle VSCode launch.json |

### Harpoon

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ha` | n | Add file |
| `<leader>hh` | n | Quick menu |
| `<leader>h1-4` | n | Jump to file 1-4 |
| `<leader>hp/hn` | n | Previous / next file |

### Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `aa` / `ia` | Outer / inner argument |
| `]m` / `[m` | Next / prev function start |
| `]]` / `[[` | Next / prev class start |
| `<leader>a` / `<leader>A` | Swap argument forward / backward |

### Snippets

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl-j` | i/s | Expand or jump forward |
| `Ctrl-k` | i/s | Jump backward |

### Diagnostics (Trouble)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>xx` | n | Toggle all diagnostics |
| `<leader>xX` | n | Toggle buffer diagnostics |
| `<leader>xl` | n | Location list |
| `<leader>xq` | n | Quickfix list |
| `<leader>xs` | n | Symbols |

### Other

| Key | Mode | Action |
|-----|------|--------|
| `<leader>u` | n | Toggle undotree |
| `<leader>wm` | n | Maximize window |
| `<leader>sm` | n | Toggle Markview |
| `<leader>?l` | n | Which-key: buffer keymaps |
| `<leader>?g` | n | Which-key: global keymaps |

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
