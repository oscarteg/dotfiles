function bf --description 'Fuzzy finds file and opens in bat'
    # Check if a search term is provided
    if test (count $argv) -eq 0
        echo "Provide a <search_term>"
        return 1
    end

    fd -t f $argv | fzf --header "Select the file you want to open" --preview="bat --style=numbers --color=always --line-range=:500 {}" | xargs -r bat
end
