# autosplit.nvim

> [!TIP]
> This autocmd will probably provide the behavior you're looking for:
> ```lua
> vim.api.nvim_create_autocmd('WinNew', {
>   callback = function()
>     if vim.fn.win_gettype(0) ~= '' then
>       return
>     end
>     if vim.api.nvim_win_get_width(0) > 2 * 80 then
>       vim.cmd.wincmd(vim.o.splitright and 'L' or 'H')
>     end
>   end
> })
> ```

This plugin adds the user command `:Sp[lit]` to Neovim. It works the same as
Neovim's `:sp[lit]` and `:vs[plit]`, but can be configured to split
automatically, always horizontal or always vertical. The automatic split is
based on if the current window is wider than than your preferred minimal window
width.


## Installation

Use `'yochem/autosplit.nvim'` with your package manager.


## Configuration

Currently, these are the options you can configure and their defaults:

```lua

require('autosplit').setup({
    split = 'auto', -- choose one of 'auto', 'horizontal' and 'vertical'
    min_win_width = 80 -- the minimal width you want for a splitted window
})
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

This abbreviation however does not work when using a count (`:10sp ` does not
change to `:10Sp `).


## Heuristic for auto option

The current heuristic for the auto option whether to split vertical or
horizontal is based on if the current window can split in two N-column windows,
with N being configurable. If you think there is a better heuristic, for
example using the ratio between window width and height, let me know!
