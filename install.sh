#!/usr/bin/env bash
#
# Dotfiles install script
# Run this after cloning the dotfiles repo to set up external tools
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Ensure ~/.local/bin exists
mkdir -p "$BIN_DIR"

# ---------------------------------------------------------------------------
# git-sync
# ---------------------------------------------------------------------------
install_git_sync() {
    local git_sync_repo="$SCRIPT_DIR/../git-sync"

    if [[ -f "$git_sync_repo/git-sync" ]]; then
        ln -sf "$git_sync_repo/git-sync" "$BIN_DIR/git-sync"
        info "git-sync installed to $BIN_DIR/git-sync"
    else
        warn "git-sync repo not found at $git_sync_repo"
        warn "Clone it with: git clone https://github.com/mct-dev/git-sync.git $git_sync_repo"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    info "Installing dotfiles tools..."
    echo ""

    install_git_sync

    echo ""
    info "Done! Make sure $BIN_DIR is in your PATH."
}

main "$@"
