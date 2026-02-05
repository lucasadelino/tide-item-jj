function __set_x_default
    set name $argv[1]
    set value $argv[2]
    if not set -q $name
        set -x $name $value
    end
end

__set_x_default tide_jj_color_upstream magenta
__set_x_default tide_jj_color_added green
__set_x_default tide_jj_color_copied green
__set_x_default tide_jj_color_modified cyan
__set_x_default tide_jj_color_removed red
__set_x_default tide_jj_color_renamed cyan
