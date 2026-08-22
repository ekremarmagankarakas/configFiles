#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ─────────────────────────────────────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'

info()          { echo -e "${BLUE}[info]${NC}  $*"; }
ok()            { echo -e "${GREEN}[ok]${NC}    $*"; }
warn()          { echo -e "${YELLOW}[skip]${NC}  $*"; }
err()           { echo -e "${RED}[err]${NC}   $*" >&2; }
step()          { echo -e "\n${BOLD}── $* ──${NC}\n"; }
cmd_exists()    { command -v "$1" &>/dev/null; }

# ─────────────────────────────────────────────────────────────────────────────
# Guard
# ─────────────────────────────────────────────────────────────────────────────

if [[ "$(uname -s)" != "Darwin" ]]; then
  err "This script is for macOS only."; exit 1
fi

echo ""
echo -e "${BOLD}macOS Dotfiles Setup${NC}"
echo -e "Dotfiles: ${BOLD}$DOTFILES_DIR${NC}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# 1/5 · Homebrew
# ─────────────────────────────────────────────────────────────────────────────

step "1/5 · Homebrew"

if cmd_exists brew; then
  ok "Homebrew already installed ($(brew --version | head -1))"
else
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add to PATH for Apple Silicon (script continues in same session)
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  ok "Homebrew installed"
fi

brew update --quiet

# ─────────────────────────────────────────────────────────────────────────────
# 2/5 · Brew bundle (packages, casks, VS Code extensions, npm globals)
# ─────────────────────────────────────────────────────────────────────────────

step "2/5 · Brew bundle"

info "Running brew bundle from $DOTFILES_DIR/brew/Brewfile..."
info "This installs all CLI tools, GUI apps, and VS Code extensions — may take a while."
brew bundle --file="$DOTFILES_DIR/brew/Brewfile" --no-lock
ok "Brew bundle complete"

# ─────────────────────────────────────────────────────────────────────────────
# 3/5 · fzf shell integration (generates ~/.fzf.zsh sourced in zshrc.mac)
# ─────────────────────────────────────────────────────────────────────────────

step "3/5 · fzf shell integration"

if [[ -f "$HOME/.fzf.zsh" ]]; then
  ok "~/.fzf.zsh already exists"
else
  info "Running fzf install script..."
  "$(brew --prefix)/opt/fzf/install" \
    --key-bindings --completion --no-update-rc --no-bash --no-fish
  ok "~/.fzf.zsh generated"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 4/5 · Bun (sourced at bottom of zshrc.mac via ~/.bun)
# ─────────────────────────────────────────────────────────────────────────────

step "4/5 · Bun"

if cmd_exists bun; then
  ok "Bun already installed ($(bun --version))"
else
  info "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  ok "Bun installed → $HOME/.bun"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 5/5 · Default shell + dotfiles
# ─────────────────────────────────────────────────────────────────────────────

step "5/5 · Shell & dotfiles"

ZSH_PATH="$(brew --prefix)/bin/zsh"
CURRENT_SHELL="$(dscl . -read ~/ UserShell | awk '{print $2}')"

if [[ "$CURRENT_SHELL" == "$ZSH_PATH" ]]; then
  ok "Homebrew zsh already default shell"
else
  # Ensure brew's zsh is in /etc/shells
  if ! grep -qF "$ZSH_PATH" /etc/shells; then
    info "Adding $ZSH_PATH to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  info "Changing default shell to Homebrew zsh..."
  chsh -s "$ZSH_PATH"
  ok "Default shell → $ZSH_PATH (takes effect on next login)"
fi

info "Running install.sh mac..."
"$DOTFILES_DIR/install.sh" mac

# ─────────────────────────────────────────────────────────────────────────────
# Done
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}── Setup complete ──${NC}"
echo ""
echo -e "Next steps:"
echo -e "  ${BOLD}1.${NC} Re-login or run:  exec zsh"
echo -e "  ${BOLD}2.${NC} Open tmux → press Ctrl-s + I to install plugins (catppuccin, yank, etc.)"
echo -e "  ${BOLD}3.${NC} Open nvim → Mason auto-installs all LSPs on first launch"
echo -e "  ${BOLD}4.${NC} Run:  p10k configure  (sets up Powerlevel10k prompt)"
echo -e "  ${BOLD}5.${NC} Grant Accessibility permissions: AeroSpace"
echo -e "  ${BOLD}6.${NC} Grant Screen Recording permission: AeroSpace (for window detection)"
echo -e "  ${BOLD}7.${NC} Launch AeroSpace from Applications"
echo ""
echo -e "${YELLOW}Note:${NC} Some casks (AeroSpace) require manual permission grants"
echo -e "      in System Settings → Privacy & Security."
echo ""
