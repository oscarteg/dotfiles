" Ale and COC together"
let g:ale_sign_column_always = 1
" let g:ale_disable_lsp = 1

" Auto reload when file on disk changes
set autoread

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2 expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Search for case when search has case
set smartcase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Auto reload .vimrc when it has changes
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
" Set wildignore
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Commands
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Completion
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Language
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'yaegassy/coc-intelephense', {'do': 'yarn install --frozen-lockfile'}
" Integrations
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Styling
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'raphamorim/lucario'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'yashguptaz/calvera-dark.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'cseelus/vim-colors-lucid'
Plug 'ayu-theme/ayu-vim'
" Syntax
Plug 'styled-components/vim-styled-components'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'jparise/vim-graphql'
Plug 'evanleck/vim-svelte'
Plug 'cespare/vim-toml'
Plug 'jordwalke/vim-reasonml'
" Other
Plug 'vimwiki/vimwiki'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'


call plug#end()

" Enable statusline with lightline
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" NERD TREE """""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""

" Nerdtree configuration
" Shortcut to open and close NERDTree
map <C-n> :NERDTreeToggle<CR>

" Close vim if the only window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change Dir and Root dir
let g:NERDTreeChDirMode = 2

let NERDTreeNaturalSort = 1


""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" THEMING """""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
" for vim 8
if (has("termguicolors"))
set termguicolors
endif

" colorscheme OceanicNext
" let ayucolor = "dark"
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
let g:calvera_italic_comments = 1
let g:calvera_italic_keywords = 1
let g:calvera_italic_functions = 1
let g:calvera_contrast = 1

colorscheme calvera

" Airline
let g:airline_theme='oceanicnext'

""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" ALE """""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_fixers = {
                   \ 'javascript': ['prettier', 'eslint'],
                   \ 'json': ['prettier'],
                   \ 'lua': ['luafmt'],
                   \ 'mdx': ['prettier'],
                   \ 'md': ['prettier'],
                   \ 'typescript': ['prettier','eslint'],
                   \ 'javascriptreact' : ['prettier', 'eslint'],
                   \ 'typescriptreact' : ['prettier', 'eslint'],
                   \ 'go': ['gofmt'],
                   \ 'dart': ['dartfmt'],
                   \ 'rust': ['rustfmt'],
                   \ 'css': ['stylelint', 'prettier'],
                   \ 'less': ['stylelint', 'prettier'],
                   \ 'scss': ['stylelint', 'prettier'],
                   \ 'python': ['yapf'],
                   \ 'svelte': ['prettier'],
                   \ 'vue': ['prettier'],
                   \ }

let g:ale_linters = {
                \ 'php': ['php', 'langserver', 'phan'],
                \ 'json': ['prettier'],
                \ 'typescriptreact' : ['prettier', 'eslint', 'tsserver'],
                \ 'javascriptreact' : ['prettier', 'eslint'],
                \ 'javascript': ['eslint'] ,
                \ 'typescript': ['prettier', 'eslint'] ,
                \ 'rust': ['cargo'],
                \ 'go': ['gopls'],
                \ 'css': ['stylelint'],
                \ 'scss': ['stylelint'],
                \ 'less': ['stylelint'],
                \ 'svelte': ['svelteserver'],
                \ 'python': ['pylint', 'flake8'],
                \ 'vue': ['vls'],
                \ }



" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Rust
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" EMMET """""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css,typescriptreact,javascriptreact EmmetInstall
let g:user_emmet_leader_key=','
let g:user_emmet_mode='n'


""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" NERD COMMENTER """"""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" Svelte configuration
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '</script>',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]


let g:ft = ''
fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte') || (&ft == 'vue')
    let g:ft = &ft
    let cfts = context_filetype#get_filetypes()
    if len(cfts) > 0
      if cfts[0] == 'svelte'
        let cft = 'html'
      elseif cfts[0] == 'scss'
        let cft = 'css'
      else
        let cft = cfts[0]
      endif
      exe 'setf ' . cft
    endif
  endif
endfu
fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte') || (g:ft == 'vue')
    exec 'setf ' . g:ft
    let g:ft = ''
  endif
endfu



" Align comment delimiters to the left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Nerdtree config for wildignore
let NERDTreeRespectWildIgnore=1


""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""  FZF """"""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-p> :Files<CR>
inoremap <silent> <C-p> :Files<CR>

""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""" COC """""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" Coc installed extensions
let g:coc_global_extensions = [
			\ '@yaegassy/coc-intelephense',
			\ 'coc-html',
			\ 'coc-tailwindcss',
			\ 'coc-prisma',
			\ 'coc-deno',
			\ 'coc-flutter',
			\ 'coc-go',
			\ 'coc-html',
			\ 'coc-json',
			\ 'coc-pyright',
			\ 'coc-rls',
			\ 'coc-rust-analyzer',
			\ 'coc-stylelint',
			\ 'coc-svelte',
			\ 'coc-tsserver',
			\ 'coc-vetur'
			\]