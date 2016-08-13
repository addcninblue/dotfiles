"limelight settings
let g:limelight_conceal_ctermfg = 240
"autocmd FileType text	      :Limelight
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:SuperTabDefaultCompletionType = "context"
let g:minimap_highlight='Question'
"let g:ctrlp_show_hidden = 1
" let g:ctrlp_working_path_mode = 0

"status bar color
hi StatusLine ctermbg=12 ctermfg=8

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"jedi vim disable popup on dot
let g:jedi#popup_on_dot = 0

"javacomplete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
