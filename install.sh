#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# Dotfiles Installer
# Symlinks config files to their expected locations on macOS or Linux.
# Usage:
#   ./install.sh          # auto-detect platform and install everything
#   ./install.sh mac      # install only macOS configs
#   ./install.sh linux    # install only Linux configs
#   ./install.sh --dry-run          # preview what would be linked
#   ./install.sh --dry-run mac      # preview macOS only
# ──────────────────────────────────────────────────────────────────────────────

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

DRY_RUN=false
LINKED=0
SKIPPED=0
BACKED_UP=0

# ──────────────────────────────────────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────────────────────────────────────

info()    { echo -e "${BLUE}[info]${NC}  $*"; }
ok()      { echo -e "${GREEN}[ok]${NC}    $*"; }
warn()    { echo -e "${YELLOW}[skip]${NC}  $*"; }
err()     { echo -e "${RED}[err]${NC}   $*"; }

link_file() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ] && [ ! -L "$src" ]; then
        err "Source does not exist: $src"
        return 1
    fi

    local dest_dir
    dest_dir="$(dirname "$dest")"

    if $DRY_RUN; then
        echo -e "  ${BOLD}would link${NC} $dest -> $src"
        return 0
    fi

    # Create parent directory if needed
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        info "Created directory: $dest_dir"
    fi

    # Handle existing files
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ]; then
            local current_target
            current_target="$(readlink "$dest")"
            if [ "$current_target" = "$src" ]; then
                warn "Already linked: $dest"
                SKIPPED=$((SKIPPED + 1))
                return 0
            fi
        fi
        # Back up existing file
        local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        mv "$dest" "$backup"
        info "Backed up: $dest -> $backup"
        BACKED_UP=$((BACKED_UP + 1))
    fi

    ln -sf "$src" "$dest"
    ok "Linked: $dest -> $src"
    LINKED=$((LINKED + 1))
}

# ──────────────────────────────────────────────────────────────────────────────
# Platform installers
# ──────────────────────────────────────────────────────────────────────────────

install_mac() {
    echo ""
    echo -e "${BOLD}── macOS configs ──${NC}"
    echo ""

    local config_dir="$HOME/.config"

    # Zsh
    link_file "$DOTFILES_DIR/zsh/zshrc.mac" "$HOME/.zshrc"

    # Neovim
    link_file "$DOTFILES_DIR/nvim" "$config_dir/nvim"

    # Tmux
    link_file "$DOTFILES_DIR/tmux/tmux.conf" "$config_dir/tmux/tmux.conf"

    # Kitty
    link_file "$DOTFILES_DIR/kitty/kitty.conf" "$config_dir/kitty/kitty.conf"
    link_file "$DOTFILES_DIR/kitty/current-theme.conf" "$config_dir/kitty/current-theme.conf"

    # AeroSpace
    link_file "$DOTFILES_DIR/aerospace/aerospace.toml" "$config_dir/aerospace/aerospace.toml"

    # Karabiner
    link_file "$DOTFILES_DIR/karabiner/karabiner.json" "$config_dir/karabiner/karabiner.json"
    link_file "$DOTFILES_DIR/karabiner/assets" "$config_dir/karabiner/assets"
}

install_linux() {
    echo ""
    echo -e "${BOLD}── Linux configs ──${NC}"
    echo ""

    local config_dir="$HOME/.config"

    # Zsh
    link_file "$DOTFILES_DIR/zsh/zshrc.linux" "$HOME/.zshrc"

    # Neovim
    link_file "$DOTFILES_DIR/nvim" "$config_dir/nvim"

    # Tmux
    link_file "$DOTFILES_DIR/tmux/tmux.conf" "$config_dir/tmux/tmux.conf"

    # Kitty
    link_file "$DOTFILES_DIR/kitty/kitty.conf" "$config_dir/kitty/kitty.conf"
    link_file "$DOTFILES_DIR/kitty/current-theme.conf" "$config_dir/kitty/current-theme.conf"

    # i3
    link_file "$DOTFILES_DIR/i3/config" "$config_dir/i3/config"
    link_file "$DOTFILES_DIR/i3/i3blocks.conf" "$config_dir/i3/i3blocks.conf"
    link_file "$DOTFILES_DIR/i3/scripts" "$config_dir/i3/scripts"

    # Rofi
    link_file "$DOTFILES_DIR/rofi/config.rasi" "$config_dir/rofi/config.rasi"
    link_file "$DOTFILES_DIR/rofi/scripts" "$config_dir/rofi/scripts"
}

install_tmux_plugins() {
    echo ""
    echo -e "${BOLD}── Tmux Plugin Manager ──${NC}"
    echo ""

    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [ -d "$tpm_dir" ]; then
        warn "TPM already installed at $tpm_dir"
    elif $DRY_RUN; then
        echo -e "  ${BOLD}would clone${NC} TPM to $tpm_dir"
    else
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        ok "TPM installed. Start tmux and press prefix + I to install plugins."
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Dependency checks
# ──────────────────────────────────────────────────────────────────────────────

check_dependencies() {
    local platform="$1"
    local missing=()

    echo ""
    echo -e "${BOLD}── Checking dependencies ──${NC}"
    echo ""

    # Common
    for cmd in git nvim tmux zsh kitty; do
        if command -v "$cmd" &>/dev/null; then
            ok "$cmd found: $(command -v "$cmd")"
        else
            warn "$cmd not found"
            missing+=("$cmd")
        fi
    done

    # Platform-specific
    if [ "$platform" = "mac" ]; then
        for cmd in brew aerospace; do
            if command -v "$cmd" &>/dev/null; then
                ok "$cmd found"
            else
                warn "$cmd not found"
                missing+=("$cmd")
            fi
        done
    elif [ "$platform" = "linux" ]; then
        for cmd in i3 rofi; do
            if command -v "$cmd" &>/dev/null; then
                ok "$cmd found"
            else
                warn "$cmd not found"
                missing+=("$cmd")
            fi
        done
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        echo ""
        warn "Missing optional dependencies: ${missing[*]}"
        warn "Configs will still be linked, but some tools may not work until installed."
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────────────────────────────────────

print_summary() {
    echo ""
    echo -e "${BOLD}── Summary ──${NC}"
    echo ""
    if $DRY_RUN; then
        info "Dry run complete. No changes were made."
    else
        ok "Linked:    $LINKED"
        [ $SKIPPED -gt 0 ] && warn "Skipped:   $SKIPPED (already linked)"
        [ $BACKED_UP -gt 0 ] && info "Backed up: $BACKED_UP (old files saved with .backup.* suffix)"
    fi
    echo ""
}

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────

main() {
    local platform=""

    # Parse arguments
    for arg in "$@"; do
        case "$arg" in
            --dry-run) DRY_RUN=true ;;
            mac|linux) platform="$arg" ;;
            -h|--help)
                echo "Usage: ./install.sh [--dry-run] [mac|linux]"
                echo ""
                echo "Options:"
                echo "  --dry-run   Preview what would be linked without making changes"
                echo "  mac         Install only macOS configs"
                echo "  linux       Install only Linux configs"
                echo "  (none)      Auto-detect platform and install"
                exit 0
                ;;
            *)
                err "Unknown argument: $arg"
                echo "Usage: ./install.sh [--dry-run] [mac|linux]"
                exit 1
                ;;
        esac
    done

    # Auto-detect platform
    if [ -z "$platform" ]; then
        case "$(uname -s)" in
            Darwin) platform="mac" ;;
            Linux)  platform="linux" ;;
            *)
                err "Unsupported platform: $(uname -s)"
                exit 1
                ;;
        esac
    fi

    echo ""
    echo -e "${BOLD}Dotfiles Installer${NC}"
    echo -e "Platform: ${BOLD}$platform${NC}"
    echo -e "Source:   ${BOLD}$DOTFILES_DIR${NC}"
    $DRY_RUN && echo -e "${YELLOW}(dry run)${NC}"

    check_dependencies "$platform"

    case "$platform" in
        mac)   install_mac ;;
        linux) install_linux ;;
    esac

    install_tmux_plugins

    print_summary
}

main "$@"
