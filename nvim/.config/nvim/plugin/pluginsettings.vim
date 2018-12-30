"limelight settings {{{
let g:limelight_conceal_ctermfg = 240
"autocmd FileType text	      :Limelight
"limelight settings }}}

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
let b:ale_linters = ['pylint']
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

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
nnoremap <leader>= :call LanguageClient#textDocument_formatting()<CR>

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
    \ 'name' : 'css',
    \ 'priority': 9, 
    \ 'subscope_enable': 1,
    \ 'scope': ['css','scss'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    \ })

let g:pymode_python = 'python3'

set tags=./tags,tags;$HOME

" fzf
source ~/.fzf/plugin/fzf.vim
