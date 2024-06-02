function nf --description 'fuzzy finds file and opens in neovim'
    # check if a search term is provided
    if test (count $argv) -eq 0
        echo "Provide a <search_term>"
        return 1
    end

    set files (fd -t f $argv)

    # Check the number of files found
    if test (count $files) -eq 0
        echo "No files found"
        return 1
    end

    if test (count $files) -eq 1
        nvim $files[1]
    else

        fd -t f $argv | fzf --header "Select the file you want to open" --preview="bat --style=numbers --color=always --line-range=:500 {}" | xargs -r nvim
    end

end
