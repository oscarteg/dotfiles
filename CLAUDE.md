# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. The repository contains configuration files for various development tools and applications.

## Setup and Installation

The primary installation method is through the `bootstrap.sh` script:
```bash
./bootstrap.sh
```

This script uses rsync to copy dotfiles from the repository to the home directory, excluding git files, README, and other metadata files.

## Key Configuration Files

- `.tmux.conf` - tmux configuration with Ctrl+A prefix and vim-style navigation
- `.aerospace.toml` - AeroSpace tiling window manager configuration
- `.config/nvim/` - Neovim configuration using LazyVim framework
- `.gitconfig` - Git configuration
- `.macos` - macOS system preferences script

## Neovim Configuration Structure

The Neovim setup uses LazyVim as the base configuration:
- `init.lua` - Entry point that bootstraps lazy.nvim
- `lua/config/` - Core LazyVim configuration (autocmds, keymaps, options)
- `lua/plugins/` - Custom plugin configurations and overrides
- `lua/overseer/template/user/` - Custom task templates for C++ builds and script execution

## Development Workflow

Since this is a dotfiles repository, there are no traditional build/test commands. Changes are typically:
1. Edit configuration files directly
2. Test changes in the respective applications
3. Run `./bootstrap.sh` to install updated configurations

## Architecture Notes

- The repository follows a standard dotfiles structure with hidden files in the root
- Neovim configuration follows LazyVim conventions with plugin overrides in `lua/plugins/`
- Configuration files are designed to be symlinked or copied to home directory
- AeroSpace provides tiling window management for macOS