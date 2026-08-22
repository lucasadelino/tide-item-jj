function __set_default_jj_color
    set name $argv[1]
    set value $argv[2]
    if not set -q $name
        set -gx $name $value
    end
end

__set_default_jj_color tide_jj_color_upstream magenta
__set_default_jj_color tide_jj_color_added green
__set_default_jj_color tide_jj_color_copied green
__set_default_jj_color tide_jj_color_modified cyan
__set_default_jj_color tide_jj_color_removed red
__set_default_jj_color tide_jj_color_renamed cyan
__set_default_jj_color tide_jj_bg_color $tide_git_bg_color
