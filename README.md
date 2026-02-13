# Dotfiles

Cross-platform configuration files for macOS and Linux. Built around a consistent philosophy: vi-keybindings everywhere, tiling window management, and a terminal-first workflow.

## What's Included

| Tool | macOS | Linux | Docs |
|------|:-----:|:-----:|------|
| **Neovim** | [config](nvim) | [config](nvim) | [docs/neovim.md](docs/neovim.md) |
| **Tmux** | [config](tmux/tmux.conf) | [config](tmux/tmux.conf) | [docs/tmux.md](docs/tmux.md) |
| **Zsh** | [config](zsh/zshrc.mac) | [config](zsh/zshrc.linux) | [docs/shell.md](docs/shell.md) |
| **Kitty** | [config](kitty) | [config](kitty) | - |
| **AeroSpace** (tiling WM) | [config](aerospace/aerospace.toml) | - | [docs/window-management.md](docs/window-management.md) |
| **i3** (tiling WM) | - | [config](i3) | [docs/window-management.md](docs/window-management.md) |
| **Karabiner** (key remap) | [config](karabiner) | - | - |
| **Rofi** (launcher) | - | [config](rofi) | [docs/window-management.md](docs/window-management.md) |

Full keybinding reference: [docs/keymaps.md](docs/keymaps.md)

## Design Principles

- **Vi-mode everywhere** -- zsh, tmux, window managers, and Neovim all use h/j/k/l navigation
- **Tiling window management** -- i3 on Linux, AeroSpace on macOS, with matching keybindings
- **Catppuccin Mocha** as the primary theme across tmux and terminal, with a persistent theme picker in Neovim
- **Platform parity** -- both setups share the same muscle memory despite different tools

## Prerequisites

### macOS

| Tool | Install |
|------|---------|
| [Homebrew](https://brew.sh) | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| Neovim | `brew install neovim` |
| Tmux | `brew install tmux` |
| Kitty | `brew install --cask kitty` |
| AeroSpace | `brew install --cask nikitabobko/tap/aerospace` |
| Karabiner-Elements | `brew install --cask karabiner-elements` |
| Zsh plugins | `brew install zsh-autosuggestions zsh-syntax-highlighting powerlevel10k` |
| fzf | `brew install fzf && $(brew --prefix)/opt/fzf/install` |
| thefuck | `brew install thefuck` |

### Linux

| Tool | Install (Debian/Ubuntu) |
|------|-------------------------|
| Neovim | `sudo snap install nvim --classic` or build from source |
| Tmux | `sudo apt install tmux` |
| Kitty | `sudo apt install kitty` |
| i3 | `sudo apt install i3` |
| i3blocks | `sudo apt install i3blocks` |
| Rofi | `sudo apt install rofi` |
| Zsh | `sudo apt install zsh && chsh -s $(which zsh)` |
| fzf | `sudo apt install fzf` |
| Powerlevel10k | `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k` |

## Installation

```bash
git clone https://github.com/ekremarmagankarakas/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Preview what will be linked (recommended first)
./install.sh --dry-run

# Install (auto-detects platform)
./install.sh

# Or specify platform explicitly
./install.sh mac
./install.sh linux
```

The install script:
- Creates symlinks from your `~/.config/` to this repo
- Backs up any existing files (saved with `.backup.*` suffix)
- Skips files that are already correctly linked
- Installs [TPM](https://github.com/tmux-plugins/tpm) for tmux plugin management

After installation, open tmux and press `Ctrl-s` + `I` to install tmux plugins.

## Repository Structure

```
.
├── install.sh                # Symlink installer (macOS + Linux)
├── nvim/                     # -> ~/.config/nvim (shared)
│   ├── init.lua
│   ├── keymaps.md
│   └── lua/
├── tmux/
│   └── tmux.conf             # -> ~/.config/tmux/tmux.conf (shared)
├── zsh/
│   ├── zshrc.mac             # -> ~/.zshrc (macOS)
│   └── zshrc.linux           # -> ~/.zshrc (Linux)
├── kitty/                    # -> ~/.config/kitty (shared)
│   ├── kitty.conf
│   └── current-theme.conf
├── aerospace/
│   └── aerospace.toml        # -> ~/.config/aerospace/aerospace.toml (macOS)
├── karabiner/                # -> ~/.config/karabiner (macOS)
├── i3/                       # -> ~/.config/i3 (Linux)
├── rofi/                     # -> ~/.config/rofi (Linux)
└── docs/
    ├── neovim.md             # Neovim setup & plugin docs
    ├── keymaps.md            # Complete keybinding reference
    ├── tmux.md               # Tmux configuration docs
    ├── shell.md              # Zsh configuration docs
    └── window-management.md  # i3 / AeroSpace / Rofi docs
```

## Highlights

### Neovim

A full IDE-like setup built on Lazy.nvim with LSP support for 10+ languages, DAP debugging, and a persistent theme picker that lets you switch between 12 colorschemes. See [docs/neovim.md](docs/neovim.md) for the full breakdown.

### Window Management

Both platforms use tiling WMs with nearly identical keybindings. `Alt+h/j/k/l` to focus, `Alt+Shift+h/j/k/l` to move, `Alt+1-9` for workspaces. See [docs/window-management.md](docs/window-management.md).

### Shell

Zsh with Powerlevel10k, vi-mode with cursor shape changes, and a shared set of git/docker aliases across both platforms. See [docs/shell.md](docs/shell.md).

## License

MIT
