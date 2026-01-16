# nvim-in-its-entirety

A minimal Neovim plugin that provides an operator and visual-mode target for the entire buffer.

This plugin allows you to reliably select the whole file in a way that integrates cleanly with Neovim’s operator-pending and visual semantics, making it suitable for use with custom operators, repeatable motions, and text-object–like workflows.

## TL;DR

Install the plugin and map `ae` in operator-pending and visual modes:

```lua
vim.keymap.set(
  { "x", "o" },
  "ae",
  function() require("in_its_entirety").buffer() end,
  { desc = "Entire buffer" }
)
```

## Motivation

While selecting the entire buffer is trivial interactively (ggVG), doing so correctly and programmatically is very technical.

nvim-in-its-entirety provides a single, well-defined function that solves this problem cleanly.

## Prior Art

This plugin is inspired by and conceptually aligned with:

- vim-textobj-entire by kana
  https://github.com/kana/vim-textobj-entire

That plugin defines a Vimscript text object (ae / ie) for the entire buffer.
nvim-in-its-entirety reimplements the core idea in pure Lua, focused on Neovim’s API and operator correctness rather than textobj registration.

## Features

- Selects the entire buffer from the first line/column to the true end of the last line
- Works correctly in:
  - Visual mode
  - Operator-pending mode
- Minimal surface area: one function, no dependencies

## Installation

Using a plugin manager (example with `vim.pack`, neovim 0.12+):

```lua
vim.pack.add({
  "dotcore64/nvim-in-its-entirety",
})
```

## Usage

The plugin exposes a single function:

```lua
require("in_its_entirety").buffer()
```

### Visual Mode Mapping

Select the entire buffer while already in Visual mode:

```lua
vim.keymap.set("x", "ae", function()
  require("in_its_entirety").buffer()
end, { desc = "Select entire buffer" })
```

### Operator-Pending Mapping

Use the entire buffer as an operator target:

```lua
vim.keymap.set("o", "ae", function()
  require("in_its_entirety").buffer()
end, { desc = "Entire buffer (operator)" })
```

This allows commands such as:

```vim
dae    " delete entire buffer
yae    " yank entire buffer
```

## License

MIT
