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
highlight Comment cterm=italic gui=italic

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
set inccommand=nosplit                " live substitution
set ignorecase                        " ignore case while searching all lowercase
set smartcase                         " allow cases where there are uppercase
set breakindent                       " if wraps, same indent
set foldlevel=99                      " no folds on start
set noshowcmd                         " show command
set noshowmode                        " show command
set hidden                            " no write on last edit
set sidescroll=1                      " scroll individually, not as a chunk
set lazyredraw                        " redraws after all macros completed; lots faster
set signcolumn=yes
set nowrap

set wildmenu                          " allows for tab completion on edits
set listchars=tab:\ \ ,nbsp:␣,extends:>,precedes:<,eol:\ ,trail:· " for setting nonprinting characters
set list
set undofile                          " Save undo's after file closes
set undodir=$HOME/.config/nvim/undo   " where to save undo histories
set undolevels=1000                   " How many undos
set undoreload=10000                  " number of lines to save for undo

let g:currentmode={
			\ 'n'  : 'NORMAL',
			\ 'no' : 'N·OPERATOR PENDING',
			\ 'v'  : 'VISUAL',
			\ 'V'  : 'V·LINE',
			\ '' : 'V·BLOCK',
			\ 's'  : 'SELECT',
			\ 'S'  : 'S·LINE',
			\ '' : 'S·BLOCK',
			\ 'i'  : 'INSERT',
			\ 'R'  : 'REPLACE',
			\ 'Rv' : 'V·REPLACE',
			\ 'c'  : 'COMMAND',
			\ 'cv' : 'VIM EX',
			\ 'ce' : 'EX',
			\ 'r'  : 'PROMPT',
			\ 'rm' : 'MORE',
			\ 'r?' : 'CONFIRM',
			\ '!'  : 'SHELL',
			\ 't'  : 'TERMINAL'}

function! Filetype()
	if &filetype == ""
		return ""
	else
		return "[" . &filetype . "] "
endfunction

set noruler                           " statusline
set laststatus=2                      " always have statusline
set statusline=                       " statusline
set statusline+=[%{g:currentmode[mode()]}]
set statusline+=\ %.40t
set statusline+=%=                    " Switch to the right side
set statusline+=%m\                   " Modified
set statusline+=%{Filetype()}         " Filetype
set statusline+=[%3l/%L]\             " line of lines
set statusline+=[%3p%%]\              " percentage
set shortmess=IaT

set mouse=a                           " mouse settings

set splitright                        " ctags jumping in vertical split
let &previewheight=winwidth(0)/2
nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>


