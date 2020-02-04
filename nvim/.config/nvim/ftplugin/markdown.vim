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

" plugins
packadd vim-markdown
let g:polyglot_disabled = ['markdown']

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
