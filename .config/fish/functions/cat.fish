function cat --wraps cat --description 'alias cat=bat --paging=never -pp --style='plain' --theme=TwoDark $*'
    bat --paging=never -pp --style='plain' --theme=TwoDark $argv
end

