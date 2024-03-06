function git-set-upstream-to-match -d "Set the upstream of the current branch to the same branch name on the origin remote"
    set -l current_branch (git branch --show-current)
    git branch --set-upstream-to=origin/$current_branch $current_branch
end
