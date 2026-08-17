#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Installer & Symlinker
# Modular Linux & Ubuntu Workstation Setup
# ==============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BOLD="\033[1m"
NC="\033[0m"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

print_banner() {
    echo -e "${BOLD}${BLUE}"
    echo "  ____        _    __ _ _           "
    echo " |  _ \  ___ | |_ / _(_) | ___  ___ "
    echo " | | | |/ _ \| __| |_| | |/ _ \/ __|"
    echo " | |_| | (_) | |_|  _| | |  __/\__ \\"
    echo " |____/ \___/ \__|_| |_|_|\___||___/"
    echo -e "${NC}"
    echo -e "Dotfiles Installer for Ubuntu / Linux"
    echo "--------------------------------------------------"
}

link_file() {
    local src="$1"
    local dest="$2"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    mkdir -p "$dest_dir"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ "$(readlink -f "$dest" 2>/dev/null)" = "$src" ]; then
            log_success "Already linked: $dest -> $src"
            return 0
        fi
        mkdir -p "$BACKUP_DIR"
        log_warn "Backing up existing $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    ln -s "$src" "$dest"
    log_success "Linked: $dest -> $src"
}

setup_symlinks() {
    log_info "Setting up configuration symlinks..."

    # Shell (Zsh)
    link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    link_file "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"

    # Oh My Posh
    link_file "$DOTFILES_DIR/ohmyposh/clean-detailed.omp.json" "$HOME/.ohmyposh/themes/clean-detailed.omp.json"

    # Tmux
    link_file "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    link_file "$DOTFILES_DIR/tmux/.tmux.conf.work" "$HOME/.tmux.conf.work"

    # Git
    link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

    # Terminal Emulators
    link_file "$DOTFILES_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    link_file "$DOTFILES_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

    # Editors & IDEs
    link_file "$DOTFILES_DIR/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json"
    link_file "$DOTFILES_DIR/cursor/keybindings.json" "$HOME/.config/Cursor/User/keybindings.json"
    link_file "$DOTFILES_DIR/windsurf/settings.json" "$HOME/.config/Windsurf/User/settings.json"
    link_file "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

    # Custom Scripts
    mkdir -p "$HOME/bin"
    link_file "$DOTFILES_DIR/bin/optimize.sh" "$HOME/bin/optimize.sh"
    chmod +x "$DOTFILES_DIR/bin/optimize.sh" 2>/dev/null || true

    # Shell Extras
    link_file "$DOTFILES_DIR/shell-extras/.dircolors" "$HOME/.dir_colors/dircolors"
    link_file "$DOTFILES_DIR/shell-extras/.showsh_config" "$HOME/.showsh_config"
    link_file "$DOTFILES_DIR/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"

    echo ""
    log_success "All symlinks configured successfully!"
    if [ -d "$BACKUP_DIR" ]; then
        log_info "Backup of replaced files preserved in: $BACKUP_DIR"
    fi
}

main() {
    print_banner
    setup_symlinks
}

main "$@"
