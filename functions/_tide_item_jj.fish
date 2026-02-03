function _tide_item_jj
    # Get Change ID and boolean commit properties
    # Adapted from https://github.com/lukerandall/dotfiles/blob/main/starship.toml#L72
    # TODO use JJ label function for coloring?
    set wc_info (jj root >/dev/null && jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
        separate(" ",
            change_id.shortest(4),
            bookmarks,
            concat(
                if(conflict, "!"),
                if(divergent, "≠"),
                if(empty, raw_escape_sequence("\x1b[90m") ++ "ø"),
                if(hidden, "◌"),
                if(immutable, "◆"),
            ),
        raw_escape_sequence("\x1b[0m"),
        )'
    )

    # Get number of commits ahead & behind
    set ahead (jj log --quiet --color never --no-pager --no-graph --ignore-working-copy -r '~empty() & ~::trunk()' -T 'change_id.short(4) ++ " "' | wc -w)
    if test $ahead -eq 0
        set -e ahead
    end
    set behind (jj log --quiet --color never --no-pager --no-graph --ignore-working-copy -r '@..trunk()' -T 'change_id.short(4) ++ " "' | wc -w)
    if test $behind -eq 0
        set -e behind
    end

    # Get diffstats
    set -l diffstats (jj log --no-graph --color never -r @ --limit 1 -T 'diff.summary()' 2>/dev/null)
    string match -qr '(0|(?<added>.*))\n(0|(?<modified>.*))\n(0|(?<removed>.*))\n(0|(?<renamed>.*))' \
        "$(string match -r ^A $diffstats | count
        string match -r ^M $diffstats | count
        string match -r ^D $diffstats | count
        string match -r ^R $diffstats | count
        string match -r '^\?\?' $diffstats | count)"

    _tide_print_item jj $_tide_location_color$tide_git_icon' ' (echo -ns $wc_info
        set_color $tide_jj_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
        set_color $tide_jj_color_added; echo -ns ' +'$added
        set_color $tide_jj_color_modified; echo -ns ' •'$modified
        set_color $tide_jj_color_removed; echo -ns ' -'$removed
        set_color $tide_jj_color_renamed; echo -ns ' *'$renamed)
end
