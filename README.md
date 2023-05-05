# Dotfiles

Neovim requirements

## Plugins

- Luasnip

## Keybindings

- Space (SPC) is my Leader key.

### Nvim-Surround

```help
    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls
```

### Comment.nvim

- NORMAL mode

```help
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
```

### nvim-cmp

<Ctrl-y>: Confirms selection.

<Ctrl-e>: Cancel the completion.

<Down>: Navigate to the next item on the list.

<Up>: Navigate to previous item on the list.

<Ctrl-n>: If the completion menu is visible, go to the next item. Else, trigger completion menu.

<Ctrl-p>: If the completion menu is visible, go to the previous item. Else, trigger completion menu.

<Ctrl-d>: Scroll down in the item's documentation.

<Ctrl-u>: Scroll up in the item's documentation.

Extra mappings
These are the keybindings you get when you enable manage_nvim_cmp.set_extra_mappings. These enable tab completion and navigation between snippet placeholders.

<Ctrl-f>: Go to the next placeholder in the snippet.

<Ctrl-b>: Go to the previous placeholder in the snippet.

<Tab>: Enables completion when the cursor is inside a word. If the completion menu is visible it will navigate to the next item in the list.

<Shift-Tab>: When the completion menu is visible navigate to the previous item in the list.

- VISUAL mode

```help
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment
```

#### Extra mappings

These mappings are enabled by default. (config: `mappings.extra`)

- NORMAL mode

```help
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode
```

##### Examples

```help
# Linewise

`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5j` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise

`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support)
```
