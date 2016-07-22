let mapleader = "\<Space>" "sets leader to space key 
let &t_SI = "\<Esc>[6 q" "this and the next two change the cursor depending on the mode
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h 
" ^ allows for better clear menu
inoremap <C-space> <C-x><C-o> 
"allows for vim's own omnicomplete
inoremap <C-BS> <C-W>
" testing in python
nnoremap <silent> <F5> :!clear;python %<CR>
