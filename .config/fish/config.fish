set -gx EDITOR "nvim"
set -gx BROWSER "none"
set -gx INITIAL_QUERY ""
set -gx RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
set -gx FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'" \
  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
      --ansi --disabled --query "$INITIAL_QUERY" \
      --height=50% --layout=reverse

# Homebrew
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/llvm/bin

# Elixer
fish_add_path /opt/homebrew/bin/elixir

# Cargo
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.cargo/composer/bin

fish_add_path $HOME/Projects/libraries/flutter/bin

# Java
fish_add_path /opt/homebrew/opt/openjdk/bin

# Emacs
fish_add_path $HOME/.config/emacs/bin

# Remove greeting
set -e fish_greeting

# Golang
set -x GOPATH $HOME/go
fish_add_path $GOPATH/bin

# Default clang
set -gx CC clang
set -gx CFLAGS -std=c17 -Wall -Wextra

# Default clang++
set -gx CXX clang++
set -gx CXXFLAGS -std=c++17 -stdlib=libc++ -Wall -Wextra

set -gx LDFLAGS "-L /opt/homebrew/lib"
set -gx CPPFLAGS "-I /opt/homebrew/include"

set -gx CPATH "/opt/homebrew/include"
set -gx LIBRARY_PATH "/opt/homebrew/lib"

set -gx KERL_CONFIGURE_OPTIONS "--without-javac --without-jinterface --without-odbc --without-hipe"

# tmux
# ~/.tmux/plugins
fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
# ~/.config/tmux/plugins
fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

# pnpm
set -gx PNPM_HOME "/Users/oscar/Library/pnpm"
fish_add_path $PNPM_HOME
# pnpm end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/oscar/.ghcup/bin # ghcup-env

# Volta
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path $VOLTA_HOME/bin
set -gx VOLTA_FEATURE_PNPM 1

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Added by zoxide installer
zoxide init fish | source

# >>> coursier install directory >>>
set -gx PATH "$PATH:/Users/oscar/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# Onyx config
set -gx ONYX_PATH "/Users/oscar/.onyx"
fish_add_path $ONYX_PATH/bin


######
# DPG - Entertainment
###### 
# Direnv
direnv hook fish | source
fish_add_path $HOME/.mix/escripts
