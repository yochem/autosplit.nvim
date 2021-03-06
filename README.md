# autosplit.nvim

This plugin adds the user command `:Split` to Neovim. It works the same as
Neovim's `:split`, but can be configured to split automatically, always
horizontal or always vertical. The automatic split is based on if the current
window is wider than 160 characters (and can thus be split in two 80-column
windows).


## Installation

```lua
paq 'yochem/autosplit.nvim'
-- or
use 'yochem/autosplit.nvim'
```


## Configuration

Currently, there is one option to configure: the split direction you prefer.

```lua
-- choose one of 'auto', 'horizontal' and 'vertical'
require('autosplit').setup({split = 'auto'})
```


## Usage

Just replace all your usage of `:split` with `:Split`. It has the same
signature as `:split` (see [`:help
:split`](https://vimhelp.org/windows.txt.html#%3Asplit) for more information):

```vimhelp
:[N]Sp[lit] [file]
```

This means that you can open this README.md in a new horizontal split of 5
lines high using `:5Sp README.md`.

It is of course also possible to remap this to a keybinding, or even better,
use [`:cabbrev`](https://vimhelp.org/map.txt.html#%3Acabbrev) if you want to
replace `:split` with this version:

```lua
vim.cmd('cabbrev sp Sp')
vim.cmd('cabbrev split Split')
```


## Heuristic for auto option

The current heuristic for the auto option whether to split vertical or
horizontal is based on if the current window can split in two 80-column
windows. If you think there is a better heuristic, for example using the ratio
between window width and height, let me know!
