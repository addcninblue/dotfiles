augroup Textgroup
	autocmd!
	autocmd BufEnter * :SoftPencil
	:Goyo 100
	autocmd BufEnter * :set spell
	autocmd BufEnter * :cnoreabbrev q qa
	autocmd BufEnter * :cnoreabbrev wq wqa
	autocmd BufEnter * :Limelight
	autocmd BufEnter * :nnoremap <C-s> :w<CR>
	autocmd BufEnter * :inoremap <C-s> <ESC>:w<CR>i
augroup END
augroup abbreviations
	autocmd!
	autocmd BufEnter * :inoreabbrev e …
	autocmd BufEnter * :inoreabbrev -- —<space>
	"autocmd BufReadPost * i<esc>
augroup END
set nohidden
