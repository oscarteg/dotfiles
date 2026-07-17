function alpha --description 'Comment /alpha on the current branch PR to trigger an alpha release'
    if not command -q gh
        echo "Error: gh (GitHub CLI) is not installed" >&2
        return 1
    end

    # Find the PR associated with the current branch
    set -l pr (gh pr view --json number --jq '.number' 2>/dev/null)

    if test -z "$pr"
        echo "Error: no open PR found for the current branch" >&2
        return 1
    end

    echo "💬 Commenting /alpha on PR #$pr..."
    gh pr comment $pr --body '/alpha'
end
