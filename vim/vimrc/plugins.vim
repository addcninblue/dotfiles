"Plug manager here
call plug#begin('~/.vim/plugged') 
"plugins here
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'jreybert/vimagit'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
" Plug 'tpope/vim-markdown'
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'bkad/CamelCaseMotion'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim', { 'for': 'text' }
Plug 'junegunn/limelight.vim', { 'for': 'text' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'metakirby5/codi.vim', { 'for': 'python' }
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'reedes/vim-pencil', { 'for': 'text' }
Plug 'SirVer/ultisnips'
Plug 'skywind3000/asyncrun.vim'
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/YouCompleteMe' 
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
call plug#end()
" map <C-n> :NERDTreeToggle<CR>
