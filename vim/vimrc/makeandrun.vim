" nnoremap <silent><leader>m :make<CR><CR>
nnoremap <silent><leader>mm :call Make()<CR>
nnoremap <silent><leader>mc :exec "!clear;make clean"<CR>
nnoremap <silent><leader>mt :exec "!clear;make test"<CR>
nnoremap <silent><leader>mr :exec "!clear;ghc % -odir ../out -hidir ../out -o ../%:r && ../%:r && rm -r ../out"<CR>
let g:javaCommand = "Asyncrun make clean && make"
func! Make()
	if &filetype == 'java'
		exec "AsyncRun make clean && make"
	elseif &filetype == 'markdown'
		exec ":w"
		exec "AsyncRun pandoc % -o %<.pdf && zathura %<.pdf"
	else
		exec "make"
	endif
endfunc
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" nnoremap <F5> :call Run()<CR>
let g:jedi#rename_command = ""
" can't let jedi take over the <leader>r keybinding
nnoremap <leader>r :call Run()<CR>
func! Run()
	" if &filetype == 'c'
	" 	exec "!gcc % -o %<"
	" 	exec "!time ./%<"
	" elseif &filetype == 'cpp'
	" 	exec "!g++ % -o %<" " 	exec "!time ./%<"
	if &filetype == 'perl'
		exec "!clear;perl %"
	elseif &filetype == 'java'
		exec "!clear;make run"
		" exec "!clear;java -cp %:p:h %:t:r"
	elseif &filetype == 'sh'
		exec "!bash %"
	elseif &filetype == 'python'
		exec "!clear && python %"
	elseif &filetype == 'html'
		exec "!google-chrome-beta % &"
	elseif &filetype == 'go'
		exec ":GoRun"
		" exec "!clear;go run %"
	elseif &filetype == 'haskell'
		exec "!clear;runhaskell %"
	" elseif &filetype == 'mkd'
	" 	exec "!firefox %.html &"
	endif
endfunc
