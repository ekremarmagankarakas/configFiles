#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

export DEBIAN_FRONTEND=noninteractive

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
pkg_installed() { dpkg -l "$1" 2>/dev/null | grep -q "^ii"; }

clone_or_skip() {
  local repo="$1" dest="$2" name="$3"
  if [[ -d "$dest/.git" ]]; then
    warn "$name already cloned"
  else
    info "Cloning $name..."
    git clone --depth=1 "$repo" "$dest"
    ok "$name cloned → $dest"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Guard
# ─────────────────────────────────────────────────────────────────────────────

if [[ "$(uname -s)" != "Linux" ]]; then
  err "This script is for Linux only."; exit 1
fi

if ! grep -qi "ubuntu\|debian" /etc/os-release 2>/dev/null; then
  warn "Not Ubuntu/Debian — proceeding anyway, some steps may fail."
fi

echo ""
echo -e "${BOLD}Ubuntu Dotfiles Setup${NC}"
echo -e "Dotfiles: ${BOLD}$DOTFILES_DIR${NC}"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# 1/9 · Core apt packages
# ─────────────────────────────────────────────────────────────────────────────

step "1/9 · System packages"

# Enable universe repo (thefuck, btop, etc.)
sudo add-apt-repository -y universe >/dev/null 2>&1 || true
sudo apt-get update -qq

APT_PACKAGES=$(grep -v '^\s*#' "$DOTFILES_DIR/packages/apt" | grep -v '^\s*$' | tr '\n' ' ')
# shellcheck disable=SC2086
sudo apt-get install -y $APT_PACKAGES

ok "apt packages installed"

# Ubuntu renames some binaries — create symlinks in ~/.local/bin
mkdir -p "$HOME/.local/bin"

if cmd_exists fdfind && ! cmd_exists fd; then
  ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
  ok "fd → fdfind symlinked"
fi

if cmd_exists batcat && ! cmd_exists bat; then
  ln -sf "$(which batcat)" "$HOME/.local/bin/bat"
  ok "bat → batcat symlinked"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 2/9 · Node.js 22 LTS (NodeSource — apt default is too old for Mason tools)
# ─────────────────────────────────────────────────────────────────────────────

step "2/9 · Node.js 22 LTS"

if cmd_exists node && node --version 2>/dev/null | grep -qE "^v2[2-9]"; then
  ok "Node.js $(node --version) already installed"
else
  info "Installing Node.js 22 LTS via NodeSource..."
  curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - >/dev/null
  sudo apt-get install -y nodejs
  ok "Node.js $(node --version) installed"
fi

# tree-sitter-cli — required for nvim treesitter parser compilation
if ! npm list -g tree-sitter-cli &>/dev/null; then
  info "Installing tree-sitter-cli..."
  sudo npm install -g tree-sitter-cli
  ok "tree-sitter-cli installed"
else
  ok "tree-sitter-cli already installed"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 3/9 · Snap packages
# ─────────────────────────────────────────────────────────────────────────────

step "3/9 · Snap packages"

while read -r pkg rest; do
  [[ -z "$pkg" || "$pkg" == \#* ]] && continue
  if snap list "$pkg" &>/dev/null; then
    ok "$pkg already installed"
  else
    info "Installing $pkg..."
    # shellcheck disable=SC2086
    sudo snap install "$pkg" $rest
    ok "$pkg installed"
  fi
done < "$DOTFILES_DIR/packages/snap"

# ─────────────────────────────────────────────────────────────────────────────
# 4/9 · Docker
# ─────────────────────────────────────────────────────────────────────────────

step "4/9 · Docker"

if cmd_exists docker; then
  ok "Docker already installed ($(docker --version))"
else
  info "Adding Docker official repo..."
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo usermod -aG docker "$USER"
  ok "Docker installed — re-login for group membership to take effect"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 5/9 · Linuxbrew (used in zshrc: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)")
# ─────────────────────────────────────────────────────────────────────────────

step "5/9 · Linuxbrew"

if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  ok "Linuxbrew already installed"
else
  info "Installing Linuxbrew (non-interactive)..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ok "Linuxbrew installed"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 6/9 · Zsh plugins (sourced directly in zshrc.linux from ~/.zsh/)
# ─────────────────────────────────────────────────────────────────────────────

step "6/9 · Zsh plugins"

mkdir -p "$HOME/.zsh"

clone_or_skip \
  https://github.com/zsh-users/zsh-autosuggestions \
  "$HOME/.zsh/zsh-autosuggestions" \
  "zsh-autosuggestions"

clone_or_skip \
  https://github.com/zsh-users/zsh-syntax-highlighting \
  "$HOME/.zsh/zsh-syntax-highlighting" \
  "zsh-syntax-highlighting"

clone_or_skip \
  https://github.com/Aloxaf/fzf-tab \
  "$HOME/.zsh/fzf-tab" \
  "fzf-tab"

clone_or_skip \
  https://github.com/romkatv/powerlevel10k.git \
  "$HOME/.zsh/powerlevel10k" \
  "powerlevel10k"

# ─────────────────────────────────────────────────────────────────────────────
# 7/9 · Papirus icons (used in rofi config: icon-theme: "Papirus")
# ─────────────────────────────────────────────────────────────────────────────

step "7/9 · Papirus icons"

if pkg_installed papirus-icon-theme; then
  ok "Papirus already installed"
else
  info "Adding Papirus PPA..."
  sudo add-apt-repository -y ppa:papirus/papirus >/dev/null 2>&1
  sudo apt-get update -qq
  sudo apt-get install -y papirus-icon-theme
  ok "Papirus installed"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 8/9 · Directories & assets
# ─────────────────────────────────────────────────────────────────────────────

step "8/9 · Directories & assets"

for dir in \
  "$HOME/screenshots" \
  "$HOME/Pictures/Wallpapers" \
  "$HOME/AppImages"; do
  mkdir -p "$dir"
  ok "Ensured $dir"
done

# Black wallpaper referenced by feh in i3/config
if [[ ! -f "$HOME/Pictures/Wallpapers/black.png" ]]; then
  info "Creating black wallpaper..."
  if cmd_exists convert; then
    convert -size 1920x1080 xc:black "$HOME/Pictures/Wallpapers/black.png"
    ok "black.png created"
  else
    warn "imagemagick not found — create ~/Pictures/Wallpapers/black.png manually"
  fi
fi

# ─────────────────────────────────────────────────────────────────────────────
# 9/9 · Default shell + dotfiles
# ─────────────────────────────────────────────────────────────────────────────

step "9/9 · Shell & dotfiles"

ZSH_PATH="$(which zsh)"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  info "Changing default shell to zsh..."
  chsh -s "$ZSH_PATH"
  ok "Default shell → zsh (takes effect on next login)"
else
  ok "zsh already default shell"
fi

info "Running install.sh linux..."
"$DOTFILES_DIR/install.sh" linux

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

echo ""
echo -e "${YELLOW}Note:${NC} Docker requires re-login for group membership."
echo ""
