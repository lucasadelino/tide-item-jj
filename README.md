# tide-item-jj

<p align="center">
  <img 
    width="50%" 
    alt="tide_jj_e" 
    src="https://github.com/user-attachments/assets/9dd87c42-a5ec-4354-b119-40dfea8fe38c" 
  />
</p>

A [Jujutsu](https://www.jj-vcs.dev/latest/) item for
[Tide](https://github.com/IlanCosman/tide/), showing the following information
about the current commit:
  - The current change_id (with the unique prefix highlighted)
  - The closest bookmarks reachable from the current change
  - The following boolean properties:
    - conflicted
    - divergent
    - empty
    - hidden
    - immutable
  - Number of commits ahead and behind `trunk()` (i.e. unpushed and unpulled
  commits)
  - The number of files that this commit has:
    - added
    - modified
    - removed
    - renamed

## Installation

### Using Fisher
```fish
fisher install lucasadelino/tide-item-jj
```

### Manually
Download
[these functions](https://github.com/lucasadelino/tide-item-jj/tree/main/functions)
into your Fish `functions/` directory. Optionally, set the diffstat color
variables shown [here](#diffstat-colors) somewhere in your config.

## Usage
This plugin is comprised of two functions. The main one is `_tide_item_jj`, which
retrieves and prints the JJ data.

For convenience, however, you'll probably want to use the
`_tide_item_vcs` function, which checks whether the cwd is in a Git or a JJ repo
and triggers the corresponding Tide function. This way you get a single Tide item
that works for both version control systems. You can add it
[as you would any other Tide item](https://github.com/IlanCosman/tide/wiki/Configuration#items).
For instance, to set a two-line `lean` prompt that includes the `vcs` item:

```fish
set -U tide_left_prompt_items pwd vcs newline character
```

### Colors
Like Tide's `git` item, tide-item-jj uses several variables to color diffstats
in the prompt. Unlike Tide's `git`, however, tide-item-jj cannot set these
variables by default. If you want your diffstats to be colored, you'll need to
set the following variables:

  - `tide_jj_color_upstream`
  - `tide_jj_color_added`
  - `tide_jj_color_copied`
  - `tide_jj_color_modified`
  - `tide_jj_color_removed`
  - `tide_jj_color_renamed`


If you use a
[rainbow](https://github.com/IlanCosman/tide/blob/assets/images/header.png)
style prompt, also set `tide_jj_bg_color`.

If you installed tide-item-jj via Fisher, all this is done for you via
`conf.d/tide_jj_colors`, which sets the above variables to the ANSI colors that
JJ uses by default. If you installed tide-item-jj manually, either copy
the conf.d file if you want those ANSI defaults or `set -gx` the variables
somewhere in your config.

## See also
- [This section](https://github.com/jj-vcs/jj/wiki/Fish-shell#prompt) on the
  Jujutsu repo wiki, for other prompts
- [This plugin](https://github.com/lucasadelino/jjtrack) by yours truly, if you'd like to access some of this data from Neovim
