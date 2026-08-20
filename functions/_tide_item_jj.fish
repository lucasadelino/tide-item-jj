function _tide_item_jj
    # Get Change ID and boolean commit properties
    # Adapted from https://github.com/lukerandall/dotfiles/blob/main/starship.toml#L72
    set wc_info (jj root >/dev/null && jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
        separate(" ",
            concat(
                if(conflict, label("working_copy conflict", "!")),
                if(divergent, label("working_copy divergent", "≠")),
                if(empty, label("working_copy empty", "ø")),
                if(hidden, label("elided", "◌")),
                if(immutable, label("node immutable", "◆")),
            ),
            change_id.shortest(4),
            bookmarks,
        raw_escape_sequence("\x1b[0m"),
        )'
    )

    # JJ resets all terminal colors after some labels. Replace those resets with
    # the Git item's base colors so they do not erase Tide's background color.
    set -l item_reset (set_color normal; set_color $tide_git_color_branch -b $tide_git_bg_color)
    set wc_info (string replace --all \e'[0m' $item_reset -- $wc_info)

    # Get number of commits ahead & behind
    # Ahead: all non-empty, mutable commits that are reachable from @ and are not
    # already present in the remote bookmarks.
    set ahead (
        jj log \
            --quiet --color never --no-pager --no-graph --ignore-working-copy \
            -r '(@:: | ::@)
                & ~empty()
                & ~::remote_bookmarks()
            ' \
            -T 'change_id.short(4) ++ " "' \
        | wc -w | string trim
    )
    if test $ahead -eq 0
        set -e ahead
    end

    # Behind: all mutable commits in that are reachable from @ and have remote,
    # but NOT local, bookmarks
    set behind (
        jj log \
            --quiet --color never --no-pager --no-graph --ignore-working-copy \
            -r '@+::remote_bookmarks()' \
            -T 'change_id.short(4) ++ " "' | wc -w | string trim)
    if test $behind -eq 0
        set -e behind
    end

    # Get diffstats
    set -l diffstats (jj log --no-graph --color never -r @ --limit 1 -T 'diff.summary()' 2>/dev/null)
    string match -qr '(0|(?<added>.*))\n(0|(?<copied>.*))\n(0|(?<modified>.*))\n(0|(?<removed>.*))\n(0|(?<renamed>.*))' \
        "$(string match -r ^A $diffstats | count
        string match -r ^C $diffstats | count
        string match -r ^M $diffstats | count
        string match -r ^D $diffstats | count
        string match -r ^R $diffstats | count
        string match -r '^\?\?' $diffstats | count)"

    # Reuse Tide's Git palette so the VCS item has a defined foreground and
    # background without requiring additional user configuration.
    _tide_print_item git $_tide_location_color$tide_git_icon' ' (echo -ns $wc_info
        set_color $tide_jj_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
        set_color $tide_jj_color_added; echo -ns ' +'$added
        set_color $tide_jj_color_copied; echo -ns ' &'$copied
        set_color $tide_jj_color_modified; echo -ns ' •'$modified
        set_color $tide_jj_color_removed; echo -ns ' -'$removed
        set_color $tide_jj_color_renamed; echo -ns ' *'$renamed)
end
