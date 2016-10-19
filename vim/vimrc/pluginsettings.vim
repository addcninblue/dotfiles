"limelight settings {{{
let g:limelight_conceal_ctermfg = 240
"autocmd FileType text	      :Limelight
"limelight settings }}}

" YCM {{{

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" " better keybindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" YCM and jedi
let g:ycm_python_binary_path = '/usr/bin/python3'

let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" YCM }}}

" vim-jedi {{{

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" vim-jedi }}}

"javacomplete {{{

autocmd FileType java setlocal omnifunc=javacomplete#Complete
"imports all missing
autocmd FileType java nnoremap <leader>i <Plug>(JavaComplete-Imports-AddSmart)

"javacomplete }}}

"camelcasemotion {{{

call camelcasemotion#CreateMotionMappings(',')
vmap ,w <Esc>l,bv,e
omap ,w :normal v,w<CR>

"camelcasemotion }}}

" ack.vim {{{

let g:ackprg = 'ag --vimgrep'

" ack.vim }}}

" undotree {{{
nnoremap <silent> <leader>u :UndotreeToggle<CR>:wincmd h<CR>
" undotree }}}

" ale {{{
let g:ale_sign_column_always = 1
" ale }}}
