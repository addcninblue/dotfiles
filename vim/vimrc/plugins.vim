"Plug manager here
call plug#begin('~/.vim/plugged') 
"plugins here
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/limelight.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-commentary'
Plug 'takac/vim-hardtime'
call plug#end()
map <C-n> :NERDTreeToggle<CR>
