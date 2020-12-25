" let &t_SI = "\<Esc>[6 q" "this and the next two change the cursor depending on the mode
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h 
cnoremap w!! w suda://%
" testing in python
nnoremap <leader>f za
nnoremap <leader>F zA
nnoremap <leader>s :so $MYVIMRC<CR>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"escape char
inoremap jk <ESC>
cnoremap jk <C-c>
vnoremap jk <ESC>

"tab switching
nnoremap <leader>j gt
nnoremap <leader>k gT
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 10gt

" Telescope
" nnoremap <C-p> :lua require'telescope.builtin'.find_files{}<CR>
" nnoremap <C-b> :lua require'telescope.builtin'.buffers{}<CR>
" nnoremap <leader>gg :lua require'telescope.builtin'.live_grep{}<cr>

nnoremap <C-p> :FZF<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <leader>gg :Rg<CR>

" DiffSaved
nnoremap <silent> <leader>d :DiffSaved<CR>

nnoremap <leader>b :buffers<CR>:buffer<Space>

nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>Y "+y$

nnoremap Y y$

nnoremap <leader>= mmgg=G`m

nnoremap <silent> <leader>] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" for Hastebin
nnoremap <leader>h :%! haste<CR>"+yyu

" Ranger
let g:ranger_map_keys = 0
" nnoremap <leader>e :Ranger<CR>

nnoremap <silent> <leader>e :MarkdownEditBlock<CR>

" language servers
nnoremap [e :LspPreviousError<CR>
nnoremap ]e :LspNextError<CR>
nnoremap [r :LspPreviousReference<CR>
nnoremap ]r :LspNextPrevious<CR>
nnoremap <S-k> :LspHover<CR>

" vimwiki
function Writemode()
	Goyo
	Limelight
	set spell
	set linebreak
	set wrap
endfunction
nnoremap <leader>wq :call Writemode()<CR>

" vim tmux runner (VTR)
nnoremap <leader>va :VtrAttachToPane<CR>
nnoremap <leader>vs :VtrSendLinesToRunner<CR>
vnoremap <leader>vs :VtrSendLinesToRunner<CR>

" change linebreak
nnoremap yob :set linebreak!<CR>
