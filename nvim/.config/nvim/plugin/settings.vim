syntax on
set t_Co=256
colorscheme solarized

"solarized settings
let g:solarized_contrast="high"
set background=dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE
highlight LineNr ctermbg=NONE
highlight SignColumn ctermbg=NONE

highlight Normal guibg=#002b36
highlight nonText guibg=#002b36
highlight SpecialKey guibg=#002b36
highlight LineNr guibg=#002b36
highlight SignColumn guibg=#002b36

"status bar color
highlight StatusLine ctermbg=12 ctermfg=8
highlight VertSplit ctermbg=NONE
highlight StatusLine guibg=#002b36 guifg=#eee8d5
highlight VertSplit guibg=#002b36
highlight CursorLineNr guifg=#eee8d5

filetype plugin indent on
set backspace=indent,eol,start        " sane backspace
set number                            " shows line number on current line
set relativenumber                    " shows relative line numbers on all other lines
set hlsearch                          " highlight items matching in search
set incsearch                         " go to next matching item while typing
set ignorecase                        " ignore case while searching all lowercase
set smartcase                         " allow cases where there are uppercase
set breakindent                       " if wraps, same indent
set foldlevel=99                      " no folds on start
set showcmd                           " show command
set hidden                            " no write on last edit
set sidescroll=1                      " scroll individually, not as a chunk
set lazyredraw                        " redraws after all macros completed; lots faster

set wildmenu                          " allows for tab completion on edits
set listchars=tab:\ \ ,eol:\ ,trail:· " for setting nonprinting characters
set list
set undofile                          " Save undo's after file closes
set undodir=/home/addison/.vim/undo   " where to save undo histories
set undolevels=1000                   " How many undos
set undoreload=10000                  " number of lines to save for undo

set noruler                           " statusline
set laststatus=2                      " always have statusline
set statusline=%.40t
set statusline+=%=                    " Switch to the right side
set statusline+=%m\                   " Modified
set statusline+=%y\                   " Modified
set statusline+=[%3l/%L]\             " line of lines
set statusline+=[%3p%%]\              " percentage
set shortmess=I

set mouse=a                           " mouse settings

set splitright                        " ctags jumping in vertical split
let &previewheight=winwidth(0)/2
nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>

