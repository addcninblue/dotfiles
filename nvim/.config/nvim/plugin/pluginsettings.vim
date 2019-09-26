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

" vim-instant-markdown {{{
let g:instant_markdown_autostart = 0
" vim-instant-markdown }}}

" vim-markdown {{{
let g:markdown_fenced_languages = ['java', 'perl', 'html', 'python', 'bash=sh', 'c']
" vim-markdown }}}

" vim-markdown {{{
" let g:markdown_enable_folding = 1
let g:markdown_enable_mappings = 0
" nnoremap <leader>e :MarkdownEditBlock<CR>
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

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
if executable('gopls')
	" go client
	au User lsp_setup call lsp#register_server({
		\ 'name': 'gopls',
		\ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
		\ 'whitelist': ['go'],
		\ })
	autocmd BufWritePre *.go silent! LspDocumentFormatSync
endif

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

" " below command made it not work for some reason
" \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

if executable('/home/addison95132/.local/bin/elixir-ls/rel/language_server.sh')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'elixir-ls',
		\ 'cmd': {server_info->['/home/addison95132/.local/bin/elixir-ls/rel/language_server.sh']},
		\ 'whitelist': ['elixir', 'eelixir'],
		\})
	autocmd BufWritePre *.exs silent! LspDocumentFormatSync
	autocmd BufWritePre *.ex silent! LspDocumentFormatSync
endif

let g:lsp_diagnostics_echo_cursor = 1

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

let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"

inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
let g:UltiSnipsJumpForwardTrigger	= "<Tab>"
let g:UltiSnipsJumpBackwardTrigger	= "<S-Tab>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

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

autocmd BufNewFile *.graphql  setfiletype graphql
autocmd BufNewFile *.graphqls setfiletype graphql
autocmd BufNewFile *.gql      setfiletype graphql
autocmd BufReadPost *.graphql  setfiletype graphql
autocmd BufReadPost *.graphqls setfiletype graphql
autocmd BufReadPost *.gql      setfiletype graphql
