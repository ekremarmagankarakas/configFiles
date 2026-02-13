# Tmux Configuration

Both macOS and Linux share the same tmux setup with minor path differences.

## Key Settings

| Setting | Value |
|---------|-------|
| Prefix | `Ctrl-s` (default `Ctrl-b` is unbound) |
| Shell | `/bin/zsh` (Mac) / `/usr/bin/zsh` (Linux) |
| Mode keys | vi |
| Mouse | enabled |
| Base index | 1 (windows and panes start at 1, not 0) |
| True color | enabled via `tmux-256color` + terminal overrides |
| Kitty graphics | passthrough enabled (Mac) |

## Keybindings

All keybindings use the prefix `Ctrl-s` unless noted otherwise.

### Navigation

| Key | Action |
|-----|--------|
| `prefix + h` | Select pane left |
| `prefix + j` | Select pane down |
| `prefix + k` | Select pane up |
| `prefix + l` | Select pane right |

### Session Management

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + d` | Detach from session |
| `prefix + s` | List sessions |
| `prefix + $` | Rename session |

### Windows

| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + ,` | Rename window |
| `prefix + n` / `prefix + p` | Next / previous window |
| `prefix + 1-9` | Switch to window by number |
| `prefix + &` | Close window |

### Panes

| Key | Action |
|-----|--------|
| `prefix + %` | Vertical split |
| `prefix + "` | Horizontal split |
| `prefix + x` | Close pane |
| `prefix + z` | Toggle pane zoom (fullscreen) |
| `prefix + {` / `prefix + }` | Swap pane left / right |

### Copy Mode (vi)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Yank selection (via tmux-yank) |
| `q` | Exit copy mode |

## Theme

[Catppuccin Mocha](https://github.com/catppuccin/tmux) (v2.1.2) with rounded window status style.

Status bar shows:
- **Left**: empty (clean look)
- **Right**: application name, session name, uptime

## Plugins

Managed by [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager).

| Plugin | Purpose |
|--------|---------|
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | System clipboard integration |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Catppuccin Mocha theme |

### Installing Plugins

After linking the config:

1. Start tmux
2. Press `prefix + I` (capital I) to install plugins via TPM
3. Press `prefix + U` to update plugins

If TPM is not installed, the install script handles it automatically.

## Platform Differences

| Setting | macOS | Linux |
|---------|-------|-------|
| Shell path | `/bin/zsh` | `/usr/bin/zsh` |
| Kitty passthrough | `set -g allow-passthrough on` | not set |
| Terminal override | `*:Tc` | `xterm*:Tc` |
