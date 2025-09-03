set -gx EDITOR nvim
set -gx INITIAL_QUERY ""
set -gx RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
set -gx FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
    --ansi --disabled --query "$INITIAL_QUERY" \
    --height=50% --layout=reverse

# User scripts
fish_add_path $HOME/.local/bin

# Ruby
fish_add_path /opt/homebrew/opt/ruby/bin

# Homebrew
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/llvm/bin

# Cargo
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.cargo/composer/bin
# source $HOME/.cargo/env

# Flutter
fish_add_path $HOME/Developer/libraries/flutter/bin
fish_add_path $HOME/.pub-cache/bin

# Orbstack
fish_add_path $HOME/.orbstack/bin

# Java
fish_add_path /opt/homebrew/opt/openjdk/bin

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

set -gx CPATH /opt/homebrew/include
set -gx LIBRARY_PATH /opt/homebrew/lib

set -gx KERL_CONFIGURE_OPTIONS "--without-javac --without-jinterface --without-odbc --without-hipe"

# pnpm
# set -gx PNPM_HOME /Users/oscar/Library/pnpm
# fish_add_path $PNPM_HOME
# pnpm end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Added by zoxide installer
zoxide init fish | source

# Set up fzf key bindings
fzf --fish | source

######
# DPG - Entertainment
###### 
# Direnv
direnv hook fish | source
fish_add_path $HOME/.mix/escripts

# Devbox
devbox global shellenv --init-hook | source

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
# test -r '/Users/oscar/.opam/opam-init/init.fish' && source '/Users/oscar/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration
# Ghostty configuration
# 
# 
# Set cursor style based on vi mode
#
function fish_vi_cursor --on-variable fish_bind_mode
    switch $fish_bind_mode
        case default
            echo -en "\e[2 q" # block cursor
        case insert
            echo -en "\e[6 q" # line cursor
        case visual
            echo -en "\e[2 q" # block cursor
    end
end
