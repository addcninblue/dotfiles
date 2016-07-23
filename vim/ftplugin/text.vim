augroup Textgroup
	autocmd!
	autocmd BufEnter * :SoftPencil
	:Goyo
	autocmd BufEnter * :set spell
	autocmd BufEnter * :cnoreabbrev q qa
	autocmd BufEnter * :cnoreabbrev wq wqa
	autocmd BufEnter * :Limelight
augroup END
augroup abbreviations
	autocmd!
	autocmd BufEnter * :inoreabbrev e …
	autocmd BufReadPost * i<esc>
augroup END
set nohidden
