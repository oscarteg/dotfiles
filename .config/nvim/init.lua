local api = vim.api
require("helpers")
require("ale")
-- require("coc")
require("emmet")
require("lsp")
require("mappings")
require("nerdcommenter")
require("nerdtree")
require("options")
require("treesitter")
require("theming")

vim.o.termguicolors = true

-- Ale and COC together"
vim.g.ale_sign_column_always = 1
-- let g:ale_disable_lsp = 1

-- Auto reload when file on disk changes
vim.o.autoread = true 

-- Use the OS clipboard by default (on versions compiled with `+clipboard`)
-- vim.o.clipboard='clipboard'
-- Enhance command-line completion
vim.o.wildmenu = true 
-- Allow backspace in insert mode
vim.o.backspace='indent,eol,start'
-- Optimize for fast terminal connections
vim.o.ttyfast = true 
-- Add the g flag to search/replace by default
vim.o.gdefault = true
-- Use UTF-8 without BOM
vim.o.bomb = false
vim.o.fileencoding="utf-8"
-- Change mapleader
vim.g.mapleader=",-- 
-- Centralize backups, swapfiles and undo history
vim.opt.backup = true
vim.opt.writebackup = false
vim.opt.backupdir="~/.vim/backups"
vim.opt.directory="~/.vim/swaps"
vim.opt.undodir="~/.vim/undo"

-- -- Don’t create backups when editing files in certain directories
vim.opt.backupskip="/tmp/*,/private/tmp/*"

-- -- Respect modeline in files
vim.o.modeline = true
vim.o.modelines=4
-- Enable per-directory .vimrc files and disable unsafe commands in them
vim.o.exrc = true
vim.o.secure = true
-- Enable line numbers
vim.o.number = true
-- Enable syntax highlighting
vim.o.syntax = "on"
-- Highlight current line
vim.o.cursorline = true
-- Make tabs as wide as two spaces
vim.o.tabstop=2
vim.o.expandtab = true
-- Show “invisible” characters
vim.wo.listchars="tab:▸ ,trail:·,eol:¬,nbsp:_"
vim.wo.list=true
-- Highlight searches
vim.o.hlsearch = true
-- Ignore case of searches
vim.o.ignorecase = true
-- Search for case when search has case
vim.o.smartcase = true
-- Highlight dynamically as pattern is typed
vim.o.incsearch = true
-- Always show status line
vim.o.laststatus=2 
-- Enable mouse in all modes
vim.o.mouse="a"
-- Don’t reset cursor to start of line when moving around.
-- TODO: Find the correct one
-- vim.o.nostartofline = "on-- 
-- Show the cursor position
vim.o.ruler = true
-- Don’t show the intro message when starting Vim
vim.o.shortmess="atI"
-- Show the current mode
vim.o.showmode = true
-- Show the filename in the window titlebar
vim.o.title = true
-- Show the (partial) command as it’s being typed
vim.o.showcmd = true
-- Use relative line numbers
vim.o.relativenumber = true
vim.api.nvim_command("au BufReadPost * set relativenumber")
-- Start scrolling three lines before the horizontal window border
vim.o.scrolloff=3


-- Enable file type detection
-- Treat .json files as .js
-- Treat .md files as Markdown
vim.api.nvim_command([[
    filetype on
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
]])

-- Set wildignore
vim.o.wildignore= vim.o.wildignore .. "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*"


-- Enable statusline with lightline
vim.o.laststatus=2

-- """"""""""""""""""""""""""""""""""""""""""""""
-- """""""""""""""-- NVIM TREE """""""""""""""""""
-- """"""""""""""""""""""""""""""""""""""""""""""

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    -- default mappings
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "s",                            cb = tree_cb("system_open") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }

vim.api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", {noremap= true, silent= true}) 
    vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap= true})
-- nnoremap <leader>r :NvimTreeRefresh<CR>


-- -- """"""""""""""""""""""""""""""""""""""""""""""
-- -- """""""""""""""-- THEMING """""""""""""""""""""
-- -- """"""""""""""""""""""""""""""""""""""""""""""
vim.g.calvera_italic_comments = 1
vim.g.calvera_italic_keywords = 1
vim.g.calvera_italic_functions = 1
vim.g.calvera_contrast = 1

vim.cmd("colorscheme calvera")

-- """"""""""""""""""""""""""""""""""""""""""""""
-- """""""""""""""-- ALE """""""""""""""""""""
-- """"""""""""""""""""""""""""""""""""""""""""""
-- You should not turn this setting on if you wish to use ALE as a completion
-- source for other completion plugins, like Deoplete.
vim.g.ale_fixers = {
                    javascript =  {'prettier', 'eslint'},
                    json= {'prettier'},
                    lua= {'luafmt'},
                    mdx= {'prettier'},
                    md= {'prettier'},
                    typescript= {'prettier','eslint'},
                    javascriptreact= {'prettier', 'eslint'},
                    typescriptreact= {'prettier', 'eslint'},
                    go= {'gofmt'},
                    dart= {'dartfmt'},
                    rust= {'rustfmt'},
                    css= {'stylelint', 'prettier'},
                    less= {'stylelint', 'prettier'},
                    scss= {'stylelint', 'prettier'},
                    python= {'yapf'},
                    svelte= {'prettier'},
                    vue= {'prettier'},
                    }

vim.g.ale_linters = {
                 php= {'php', 'langserver', 'phan'},
                 json= {'prettier'},
                 typescriptreact= {'prettier', 'eslint', 'tsserver'},
                 javascriptreact= {'prettier', 'eslint'},
                 javascript= {'eslint'},
                 typescript= {'prettier', 'eslint'},
                 rust= {'cargo'},
                 go= {'gopls'},
                 css= {'stylelint'},
                 scss= {'stylelint'},
                 less= {'stylelint'},
                 svelte= {'svelteserver'},
                 python= {'pylint', 'flake8'},
                 vue= {'vls'},
                 }



-- Set this variable to 1 to fix files when you save them.
vim.g.ale_fix_on_save = 1

-- """"""""""""""""""""""""""""""""""""""""""""""
-- """""""""""""""-- EMMET """""""""""""""""""
-- """"""""""""""""""""""""""""""""""""""""""""""
vim.g.user_emmet_install_global = 0
vim.api.nvim_command("autocmd FileType html,css,typescriptreact,javascriptreact EmmetInstall")
vim.g.user_emmet_leader_key=','
vim.g.user_emmet_mode='n'

-- """"""""""""""""""""""""""""""""""""""""""""""
-- """""""""""""""-- NERD COMMENTER """"""""""""""
-- """"""""""""""""""""""""""""""""""""""""""""""
-- Create default mappings
vim.g.NERDCreateDefaultMappings = 1

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'

-- Set a language to use its alternate delimiters by default
vim.g.NERDAltDelims_java = 1

-- Add your own custom formats or override the defaults
vim.g.NERDCustomDelimiters = { c= { left =  '/**',right= '*/' } }

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1

-- Align comment delimiters to the left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'

-- Nerdtree config for wildignore
vim.g.NERDTreeRespectWildIgnore=1

-- -- """"""""""""""""""""""""""""""""""""""""""""""
-- -- """""""""""""""--  FZF """"""""""""""
-- -- """"""""""""""""""""""""""""""""""""""""""""""
vim.api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", {noremap= true, silent= true}) 
vim.api.nvim_set_keymap("i", "<C-p>", ":Files<CR>", {noremap= true, silent= true}) 

-- -- """"""""""""""""""""""""""""""""""""""""""""""
-- -- """""""""""""""-- COC """""""""""""""""""""
-- -- """"""""""""""""""""""""""""""""""""""""""""""

-- Set internal encoding of vim, not needed on neovim, since coc.nvim using some
-- unicode characters in the file autoload/float.vim
vim.opt.encoding="utf-8"

-- TextEdit might fail if hidden is not set.
vim.opt.hidden="hidden"

-- Give more space for displaying messages.
vim.opt.cmdheight=2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime=300

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess= vim.opt.shortmess .. "c"

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
  -- Recently vim can merge signcolumn and number column into one
vim.opt.signcolumn="number"

  -- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.



inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>-- :
      \ <SID>check_back_space() ? "\<TAB>-- :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>-- : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

-- Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

-- GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

-- Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . -- -- . expand('<cword>')
  endif
endfunction

-- Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

-- Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

-- Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  -- Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  -- Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

-- Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
-- Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

-- Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>-- : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>-- : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

-- Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

-- Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

-- Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

-- Mappings for CoCList
-- Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
-- Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
-- Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
-- Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
-- Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
-- Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
-- Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
-- Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

return require("packer").startup(
    function()
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- Lazy loading:
        -- Load on specific commands
        use {"tpope/vim-dispatch", opt = true, cmd = {"Dispatch", "Make", "Focus", "Start"}}

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        use {"junegunn/fzf", run = vim.fn["fzf#install"]}
        use "junegunn/fzf.vim"
        --  Completion
        use "dense-analysis/ale"
        use {"neoclide/coc.nvim", branch = "release"}
        --  Language
        use "tpope/vim-surround"

        -- Load on a combination of conditions: specific filetypes or commands
        -- Also run code after load (see the "config-- key)
        use {
            "mattn/emmet-vim",
            ft = {"html", "css", "typescriptreact", "javascriptreact"},
            cmd = "EmmetInstall",
            config = "vim.cmd[[EmmetInstall]]"
        }

        use "preservim/nerdcommenter"
        use {"yaegassy/coc-intelephense", run = "yarn install --frozen-lockfile"}
        -- --Integrations
        use "rizzatti/dash.vim"
        use "tpope/vim-fugitive"
        use 'kyazdani42/nvim-tree.lua'
        use "airblade/vim-gitgutter"
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        --  Styling
        use "mhartington/oceanic-next"
        use "morhetz/gruvbox"
        use "raphamorim/lucario"
        use "rafi/awesome-vim-colorschemes"
        use "yashguptaz/calvera-dark.nvim"
        use "sheerun/vim-polyglot"
        use "cseelus/vim-colors-lucid"
        use "ayu-theme/ayu-vim"
        --  Syntax
        use "styled-components/vim-styled-components"
        use "fatih/vim-go"
        use "rust-lang/rust.vim"
        use "jparise/vim-graphql"
        use "evanleck/vim-svelte"
        use "cespare/vim-toml"
        use "jordwalke/vim-reasonml"
        --  Other
        use "editorconfig/editorconfig-vim"

        use {
            "vhyrro/neorg",
            config = function()
                require("neorg").setup {
                    -- Tell Neorg what modules to load
                    load = {
                        ["core.defaults"] = {}, -- Load all the default modules
                        ["core.norg.concealer"] = {}, -- Allows for use of icons
                        ["core.norg.dirman"] = {
                            -- Manage your directories with Neorg
                            config = {
                                workspaces = {
                                    my_workspace = "~/neorg"
                                }
                            }
                        }
                    }
                }
            end
        }

        use {
            "folke/twilight.nvim",
            config = function()
                require("twilight").setup {}
            end
        }
    end
)
