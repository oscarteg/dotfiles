set -gx EDITOR "nvim"
set -gx INITIAL_QUERY ""
set -gx RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
set -gx FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'" \
  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
      --ansi --disabled --query "$INITIAL_QUERY" \
      --height=50% --layout=reverse

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.cargo/composer/bin
fish_add_path $HOME/Projects/libraries/flutter/bin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path $HOME/go/bin
set -x GOPATH $HOME/go

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

fish_add_path $GOPATH/bin

# ZK
set -gx ZK_NOTEBOOK_DIR $HOME/zk


# Change default editor to nvim
set -Ux EDITOR nvim

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/oscar/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end