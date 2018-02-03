"limelight settings {{{
let g:limelight_conceal_ctermfg = 240
"autocmd FileType text	      :Limelight
"limelight settings }}}

" YCM {{{

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_autoclose_preview_window_after_completion = 1

" eclim

" let g:EclimCompletionMethod = 'omnifunc'
" let g:EclimJavaValidate = 1

" " better keybindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" YCM and jedi
let g:ycm_python_binary_path = '/usr/bin/python3'

let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" YCM and Haskell
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

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

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

" ale }}}

" vim-instant-markdown {{{
let g:instant_markdown_autostart = 0
" vim-instant-markdown }}}

" vim-markdown {{{
" let g:markdown_fenced_languages = ['java', 'perl', 'html', 'python', 'bash=sh']
" vim-markdown }}}

" vim-markdown {{{
" let g:markdown_enable_folding = 1
let g:markdown_enable_mappings = 0
nnoremap <leader>e :MarkdownEditBlock<CR>
" vim-markdown }}}

" delimitmate {{{
let delimitMate_expand_cr = 1
" delimitmate }}}

" vim-sneak {{{
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
" vim-sneak }}}

let hscoptions = "q℘𝐒𝐓𝐄𝐌sxe⇒⇔rbl↱w-iRtBQZDC1a"

" tslime {{{
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
" tslime }}}

let g:pymode_python = 'python3'

set tags=./tags,tags;$HOME
