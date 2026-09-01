function _tide_item_vcs
    # Cache _tide_location_color so that the git branch/tag/ref name prints
    if not set -q _tide_location_color
        set_color $tide_git_color_branch | read -gx _tide_location_color
    end

    if test $PWD != $HOME
        # Are we in a JJ repo?
        and jj root &>/dev/null
        # Are we NOT in a git submodule?
        and test -z "$(git rev-parse --show-superproject-working-tree)"
        _tide_item_jj
    else
        _tide_item_git
    end
end
