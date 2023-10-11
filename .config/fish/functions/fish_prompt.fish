function fish_prompt
    set_color $fish_color_cwd
    echo -n (prompt_pwd --full-length-dirs=2 )
    set_color normal
    echo -n ' ☁  '
end
