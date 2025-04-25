#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to create symbolic links
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Check if the target already exists
    if [ -e "$target" ]; then
        # If it's already a symlink to our source, do nothing
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
            echo -e "${BLUE}Link already exists:${NC} $target → $source"
            return 0
        fi
        
        # Backup existing file/directory
        local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${BLUE}Backing up:${NC} $target → $backup"
        mv "$target" "$backup"
    fi
    
    # Create the symlink
    echo -e "${GREEN}Creating symlink:${NC} $target → $source"
    ln -s "$source" "$target"
}

# Get the dotfiles directory (the directory where this script is located)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${GREEN}=== Installing dotfiles from $DOTFILES_DIR ===${NC}"

# Create necessary directories if they don't exist
mkdir -p ~/.config/kitty
mkdir -p ~/.emacs.d

# Emacs configuration
echo -e "\n${GREEN}=== Setting up Emacs configuration ===${NC}"
create_symlink "$DOTFILES_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
create_symlink "$DOTFILES_DIR/emacs/config.el" "$HOME/.emacs.d/config.el"
create_symlink "$DOTFILES_DIR/emacs/custom.el" "$HOME/.emacs.d/custom.el"
create_symlink "$DOTFILES_DIR/emacs/packages.el" "$HOME/.emacs.d/packages.el"

# Kitty configuration
echo -e "\n${GREEN}=== Setting up Kitty terminal configuration ===${NC}"
create_symlink "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Shell configuration
echo -e "\n${GREEN}=== Setting up shell configuration ===${NC}"
create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"

echo -e "\n${GREEN}=== Dotfiles installation complete! ===${NC}"
echo -e "You may need to restart your terminal or reload your shell configuration."
