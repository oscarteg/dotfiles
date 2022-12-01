function nf --description 'Fuzzy finds file and opens in neovim'
    fd -H $argv -X nvim
end
