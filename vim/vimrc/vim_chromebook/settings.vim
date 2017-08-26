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
highlight SignColumn ctermbg=NONE
"status bar color
highlight StatusLine ctermbg=12 ctermfg=8
highlight VertSplit ctermbg=NONE

highlight Normal guibg=#002b36
highlight nonText guibg=#002b36
highlight SpecialKey guibg=#002b36
highlight LineNr guibg=#002b36
highlight SignColumn guibg=#002b36
"status bar color
highlight StatusLine guibg=#002b36 guifg=#eee8d5
highlight VertSplit guibg=#002b36
highlight CursorLineNr guifg=#eee8d5

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

" no write on last edit
set hidden

set sidescroll=1

" scrolloff
" set so=99

set gfn=xos4\ Terminus\ 14

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
