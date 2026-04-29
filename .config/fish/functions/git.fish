function git -d "Git wrapper: block mutating commands inside jj repos" --wraps "git"
    set -l sub $argv[1]
    set -l blocked commit push pull fetch checkout switch restore reset rebase merge cherry-pick revert am branch tag stash clean worktree add rm mv bisect

    # Walk up looking for .jj
    set -l dir (pwd)
    set -l jj_root ""
    while test "$dir" != "/"
        if test -d "$dir/.jj"
            set jj_root $dir
            break
        end
        set dir (dirname $dir)
    end

    if test -n "$jj_root"; and contains -- "$sub" $blocked
        set_color red
        echo "blocked: 'git $sub' inside jj repo ($jj_root)" >&2
        set_color normal
        switch $sub
            case commit
                echo "  -> jj commit -m \"...\"   |   jj describe -m \"...\"" >&2
            case push
                echo "  -> jj git push -b <bookmark>" >&2
            case pull
                echo "  -> jj git fetch; jj rebase -d main@origin" >&2
            case fetch
                echo "  -> jj git fetch" >&2
            case checkout switch
                echo "  -> jj new -r <rev>   |   jj edit <rev>" >&2
            case restore
                echo "  -> jj restore <paths>" >&2
            case reset
                echo "  -> jj abandon <rev>   |   jj restore" >&2
            case rebase
                echo "  -> jj rebase -d <dest>" >&2
            case merge
                echo "  -> jj new <rev1> <rev2>" >&2
            case cherry-pick
                echo "  -> jj duplicate -d <dest> <rev>   |   jj rebase -s <rev> -d <dest>" >&2
            case revert
                echo "  -> jj backout -r <rev>" >&2
            case branch
                echo "  -> jj bookmark (list / set / move / delete)" >&2
            case tag
                echo "  -> jj has no tags; use bookmarks or bypass" >&2
            case stash
                echo "  -> jj snapshots automatically; 'jj new' to start fresh, 'jj edit' to return" >&2
            case add rm mv
                echo "  -> working copy is tracked automatically; just edit files" >&2
            case worktree
                echo "  -> jj workspace add <path>" >&2
            case clean bisect am
                echo "  -> use jj equivalent or bypass" >&2
        end
        echo "  bypass: command git $argv" >&2
        return 1
    end

    command git $argv
end
