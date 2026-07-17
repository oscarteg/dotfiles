function omo-account --description 'switch oh-my-openagent subagent models between personal (Claude Max) and work (Foundry)'
    set -l cfg_dir "$HOME/.config/opencode"
    set -l active "$cfg_dir/oh-my-openagent.json"
    set -l personal "$cfg_dir/oh-my-openagent.personal.json"
    set -l foundry "$cfg_dir/oh-my-openagent.foundry.json"

    switch "$argv[1]"
        case personal max home
            cp "$personal" "$active"
            echo "→ personal (Claude Max). Restart opencode to apply."
        case work foundry dpg
            cp "$foundry" "$active"
            echo "→ work (Foundry). Restart opencode to apply."
        case status ''
            if grep -q 'foundry-audio' "$active" 2>/dev/null
                echo "active: work (Foundry)"
            else
                echo "active: personal (Claude Max)"
            end
        case '*'
            echo "usage: omo-account [personal|work|status]" >&2
            return 1
    end
end
