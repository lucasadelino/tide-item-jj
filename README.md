# tide-item-jj

A [Jujutsu](https://www.jj-vcs.dev/latest/) item for
[Tide](https://github.com/IlanCosman/tide/), showing the following information
about the current commit:
  - The current change_id (with the unique prefix highlighted)
  - The current bookmarks, if any
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
into your Fish `functions/` directory.

## Usage
This plugin is comprised of two functions.

The main one is `_tide_item_jj`, which
retrieves and prints the JJ data. If you prefer, you can use this function
directly.

For convenience, however, you'll probably want to use the
`_tide_item_jit`[^1] function, which checks whether you are currently in a Git
or a JJ repo and then triggers the corresponding Tide function. This way you get
a single Tide item that works for both version control systems. You can then add
it
[as you would any other Tide item](https://github.com/IlanCosman/tide/wiki/Configuration#items).
For instance, to set a two-line `lean` prompt that includes the `jit` item:

```fish
set -U tide_left_prompt_items pwd jit newline character
```

(It should go without saying that if you're using `jit`, you'll likely
want to *not* use the default `git` item).

[^1]: lol
