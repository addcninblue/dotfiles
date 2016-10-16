syntax on
set t_Co=256
colorscheme solarized
" colorscheme vice

"solarized settings
let g:solarized_contrast="high"
"let g:solarized_visibility="high"
set background=dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE
highlight LineNr ctermbg=NONE
"status bar color
highlight StatusLine ctermbg=12 ctermfg=8
set backspace=indent,eol,start
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set relativenumber
set number
"set clipboard=unnamedplus
filetype plugin indent on

"vim enhancements since 07/14/16
set wildmenu "allows for tab completion on edits 
" for setting nonprinting characters
set listchars=tab:\ \ ,eol:\ ,trail:·
set list
set undofile                " Save undo's after file closes
set undodir=/home/addison/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

"statusline
"set statusline=%f         " Path to the file
set noruler
set laststatus=2
set statusline=%f
set statusline+=%=        " Switch to the right side
" set statusline+=/         " Separator
set statusline+=%L        " Total lines
set shortmess=I
" set colorcolumn=80
" highlight colorcolumn ctermbg=NONE ctermfg=9

" if wraps, same indent
set breakindent

" no folds on start
set foldlevel=99
set showcmd
