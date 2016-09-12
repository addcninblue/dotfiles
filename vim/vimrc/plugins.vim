"Plug manager here
call plug#begin('~/.vim/plugged') 
"plugins here
" Plug 'davidhalter/jedi-vim'
" Plug 'scrooloose/syntastic'
" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'bkad/CamelCaseMotion'
Plug 'ervandew/supertab'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mbbill/undotree'
Plug 'metakirby5/codi.vim'
Plug 'mileszs/ack.vim'
Plug 'reedes/vim-pencil'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'Valloric/YouCompleteMe' 
call plug#end()
map <C-n> :NERDTreeToggle<CR>
