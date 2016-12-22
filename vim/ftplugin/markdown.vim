nnoremap <leader>t vip:Tabularize/\|<CR>
nnoremap <leader>; :InstantMarkdownPreview<CR>
set autoindent
" nnoremap <silent><leader>a }kdd{jjjV}k:!perl<Space>processing.pl<CR>vip:Tabularize/\|<CR>
" nnoremap <silent><leader>a vip:!perl<Space>~/dotfiles/tools/processing.pl<CR>vip:Tabularize/\|<CR>
" nnoremap <silent><leader>a vip:!perl<Space>s:scriptLocation<CR>vip:Tabularize/\|<CR>

nnoremap <silent><leader>a vip:!perl<Space>~/dotfiles/vim/ftplugin/processing.pl<CR>vip:Tabularize/\|<CR>

let s:script = "vip:!perl " . expand('<sfile>:p:h') . "/processing.pl"
" nnoremap <leader>a :call FinanceFormat()<CR>
func! FinanceFormat()
	exec "normal! " . s:script
	exec "normal! vip:Tabularize /|\<CR>"
endfunc
