function _tide_item_vcs
    # Cache _tide_location_color so that the git branch/tag/ref name prints
    if not set -q _tide_location_color
        set_color $tide_git_color_branch | read -gx _tide_location_color
    end

    # Are we in a JJ repo?
    if test $PWD != $HOME
        and jj root &>/dev/null
        _tide_item_jj
    else
        _tide_item_git
    end
end
