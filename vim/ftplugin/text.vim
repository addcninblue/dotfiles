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
augroup END
augroup abbreviations
	autocmd!
	autocmd BufEnter * :inoreabbrev ... …
	autocmd BufEnter * :inoreabbrev -- —
	"autocmd BufReadPost * i<esc>
augroup END
set nohidden
