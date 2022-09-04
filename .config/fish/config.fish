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
fish_add_path $HOME/go/bin
set -x GOPATH $HOME/go

fish_add_path $GOPATH/bin

# ZK
set -gx ZK_NOTEBOOK_DIR $HOME/zk


# Change default editor to nvim
set -Ux EDITOR nvim

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
