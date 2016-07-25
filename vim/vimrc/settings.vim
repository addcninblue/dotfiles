syntax on
set t_Co=256
colorscheme solarized
"solarized settings
let g:solarized_contrast="high"
"let g:solarized_visibility="high"
set background=dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE
highlight LineNr ctermbg=NONE
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set relativenumber
set number
"set clipboard=unnamedplus
filetype plugin on

"vim enhancements since 07/14/16
set wildmenu "allows for tab completion on edits 
set listchars=tab:▸\ ,eol:¬
set list
set undofile                " Save undo's after file closes
set undodir=/home/addison/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo