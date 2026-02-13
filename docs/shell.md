# Shell Configuration (Zsh)

Both macOS and Linux use Zsh with a nearly identical setup.

## Prompt

[Powerlevel10k](https://github.com/romkatv/powerlevel10k) with instant prompt enabled. Run `p10k configure` to customize the prompt appearance (the config is stored in `~/.p10k.zsh`, which is not tracked in this repo since it's machine-specific).

## Vi Mode

Full vi-mode is enabled with these enhancements:

| Feature | Description |
|---------|-------------|
| Cursor shape | Block in normal mode, beam in insert mode |
| `j` / `k` in normal | History prefix search (type prefix, then j/k to filter) |
| `v` in normal | Open command in `$EDITOR` |
| `/` / `?` in normal | Incremental search backward/forward |
| Menu navigation | `h/j/k/l` in tab-completion menus |
| `Ctrl-a` / `Ctrl-e` | Beginning/end of line (works in insert mode) |
| `Ctrl-r` | Reverse history search |
| `Ctrl-w` | Delete word backward |
| `Alt-y` | Accept autosuggestion |

## History

| Setting | macOS | Linux |
|---------|-------|-------|
| History size | 10,000 | 1,000 |
| History file | `~/.zsh_history` | `~/.zsh_history` |
| Deduplication | yes (`histignorealldups`) | yes |
| Shared history | yes (`sharehistory`) | yes |

## Completion

A comprehensive completion system with:

- Case-insensitive matching
- Fuzzy matching (typo correction via `_approximate`)
- Colored output matching `LS_COLORS`
- Interactive menu selection with scrolling

## Aliases

### Navigation

| Alias | Command |
|-------|---------|
| `..` | `cd ..` |
| `ls` | `ls -G` (Mac) / `ls --color=auto` (Linux) |
| `ll` | `ls -alF` |
| `la` | `ls -A` |
| `l` | `ls -CF` |

### Git

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `ga` | `git add .` |
| `gb` | `git branch` |
| `gc` | `git commit` |
| `gca` | `git commit -am` |
| `gd` | `git diff` |
| `gl` | `git log --oneline --graph --decorate --all` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gs` | `git status` |
| `gcl` | `git clone` |
| `gco` | `git checkout` |
| `gcb` | `git checkout -b` |
| `gr` | `git restore` |

### Docker

| Alias | Command |
|-------|---------|
| `d` | `docker` |
| `dps` | `docker ps` |
| `dcu` | `docker compose up` |
| `dcub` | `docker compose up --build` |
| `dcd` | `docker compose down` |

### Other

| Alias | Command |
|-------|---------|
| `tn` | Launch/attach tmux session (via `tmux-cmd` script) |
| `grep` | `grep --color=auto` |

## Plugins

### macOS (installed via Homebrew)

| Plugin | Purpose |
|--------|---------|
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax coloring in the prompt |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy file/history finder |
| [thefuck](https://github.com/nvbn/thefuck) | Auto-correct previous command |

### Linux (cloned to `~/.zsh/`)

| Plugin | Purpose |
|--------|---------|
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax coloring in the prompt |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Replace zsh completion with fzf |
| [thefuck](https://github.com/nvbn/thefuck) | Auto-correct previous command |

## Environment Variables

### macOS

| Variable | Value |
|----------|-------|
| `EDITOR` | `/opt/homebrew/bin/nvim` |
| `PATH` | Prepends `~/.local/bin` |

### Linux

| Variable | Value |
|----------|-------|
| `EDITOR` | `/snap/bin/nvim` |
| `PATH` | Includes `~/.local/bin`, Android SDK, Go, snap, Linuxbrew |
| `ANDROID_HOME` | `$HOME/Android/Sdk` |
| `GPG_TTY` | `$(tty)` |
| `SDKMAN_DIR` | `$HOME/.sdkman` |

## Platform Differences

| Feature | macOS | Linux |
|---------|-------|-------|
| `ls` coloring | `-G` (BSD) | `--color=auto` (GNU) |
| Plugin install | Homebrew | Git clone to `~/.zsh/` |
| fzf-tab | not installed | installed |
| SDKMAN | not installed | installed |
| Android SDK | not configured | configured |
| alert alias | not present | present (notify-send) |
