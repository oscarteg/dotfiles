#!/bin/sh
# Detect the current macOS appearance and load the matching Koda tmux theme.
# Invoked once when tmux.conf loads, and manually via `prefix + T`.

if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
	tmux source-file "$HOME/.config/tmux/koda-dark.conf"
else
	tmux source-file "$HOME/.config/tmux/koda-light.conf"
fi
