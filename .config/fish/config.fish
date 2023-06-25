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

# Cargo
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.cargo/composer/bin

fish_add_path $HOME/Projects/libraries/flutter/bin

# Emacs
fish_add_path $HOME/.config/emacs/bin

# Golang
set -x GOPATH $HOME/go
fish_add_path $GOPATH/bin

# Default clang
set -gx CC clang
set -gx CFLAGS -std=c17 -Wall -Wextra

# Default clang++
set -gx CXX clang++
set -gx CXXFLAGS -std=c++20 -stdlib=libc++ -Wall -Wextra

set -gx LDFLAGS "-L /opt/homebrew/lib"
set -gx CPPFLAGS "-I /opt/homebrew/include"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/oscar/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/oscar/.ghcup/bin # ghcup-env
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
