function tf --description "Attach to a tmux session"
    # Check if tmux is running
    if not type -q tmux
        echo "tmux is not installed or not in PATH."
        return 1
    end

    # Use fzf to select a session
    set selected_session (tmux  list-sessions -F "#{session_name}"| fzf --height 40% --reverse --border --prompt="Select tmux session: ")

    # If a session was selected, attach to it
    if test -n "$selected_session"
        tmux switch -t "$selected_session"
    else
        echo "No session selected."
    end
end
