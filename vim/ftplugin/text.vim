augroup Textgroup
	autocmd!
	autocmd BufEnter * :SoftPencil
	autocmd BufEnter * :Goyo 100
	autocmd BufEnter * :set spell
	autocmd BufEnter * :cnoreabbrev q qa
	autocmd BufEnter * :cnoreabbrev wq wqa
	autocmd BufEnter * :Limelight
	autocmd BufEnter * :nnoremap <C-s> :w<CR>
	autocmd BufEnter * :inoremap <C-s> <ESC>:w<CR>i
	autocmd BufEnter * :nnoremap <leader>ww :w !wc -w<CR>
	autocmd BufEnter * :nnoremap <leader>wc :w !wc -m<CR>
	autocmd BufEnter * :nnoremap <leader>wl :w !wc -l<CR>
augroup END

" augroup abbreviations
" 	autocmd!
" 	autocmd BufEnter * :inoreabbrev ... …
" 	autocmd BufEnter * :inoreabbrev -- —
" 	autocmd BufEnter * :inoremap 'a á
" 	autocmd BufEnter * :inoremap 'e é
" 	autocmd BufEnter * :inoremap 'i í
" 	autocmd BufEnter * :inoremap 'o ó
" 	autocmd BufEnter * :inoremap 'u ú
" 	autocmd BufEnter * :inoremap ~n ñ
" 	"autocmd BufReadPost * i<esc>
" augroup END

set nohidden

" plugins
packadd goyo.vim
packadd limelight.vim
packadd vim-pencil
