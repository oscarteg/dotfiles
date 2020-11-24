set background=dark
set guifont=Dank\ Mono:14

" Load the MacVim color scheme.  This can be disabled by loading another color
" scheme with the :colorscheme command, or by adding the line
"   let macvim_skip_colorscheme=1
" to ~/.vimrc.
if !exists("macvim_skip_colorscheme") && !exists("colors_name")
    colorscheme macvim
endif

if has("gui_running")
    colorscheme solarized
else
    colorscheme grb256
endif

