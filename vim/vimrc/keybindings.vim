let mapleader = "\<Space>" "sets leader to space key 
let &t_SI = "\<Esc>[6 q" "this and the next two change the cursor depending on the mode
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h 
cnoremap w!! w !sudo tee % > /dev/null
" allows for better clear search
inoremap <C-space> <C-x><C-o> 
"allows for vim's own omnicomplete
inoremap <C-BS> <C-W>
" testing in python
nnoremap <leader>f za
nnoremap <leader>F zA
" nnoremap <leader>p :execute "rightbelow vsplit " . bufname("#")<CR>
nnoremap <leader>s :so $MYVIMRC<CR>
nnoremap <leader>ss :so $MYVIMRC<CR>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"escape char
inoremap jk <ESC>
cnoremap jk <C-c>
vnoremap jk <ESC>

"tab switching
nnoremap <leader>j gT
nnoremap <leader>k gt

" FZF
nnoremap <C-p> :FZF<CR>

" DiffSaved
nnoremap <silent> <leader>d :DiffSaved<CR>

" Window Changing
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

nnoremap <leader>b :buffers<CR>:buffer<Space>

nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap Y y$
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader>= mmgg=G`m

nnoremap <silent> <leader>] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

nnoremap <CR> o<ESC>k
nnoremap \ O<ESC>j

" for Simplenote
nnoremap <leader>sl :SimplenoteList<CR>
nnoremap <leader>su :SimplenoteUpdate<CR>
nnoremap <leader>sn :SimplenoteNew<CR>
nnoremap <leader>sd :SimplenoteTrash<CR>
nnoremap <leader>st :SimplenoteTrash<CR>

" for Hastebin
nnoremap <leader>h :%! haste<CR>"+yyu
