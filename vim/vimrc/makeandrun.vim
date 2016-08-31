nnoremap <silent><leader>m :make<CR><CR>
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
	" 	exec "!g++ % -o %<"
	" 	exec "!time ./%<"
	if &filetype == 'java'
		exec "!clear;java -cp %:p:h %:t:r"
	elseif &filetype == 'sh'
		exec "!bash %"
	elseif &filetype == 'python'
		exec "!python %"
	elseif &filetype == 'html'
		exec "!google-chrome-beta % &"
	elseif &filetype == 'go'
		exec "!go run %"
	" elseif &filetype == 'mkd'
	" 	exec "!firefox %.html &"
	endif
endfunc
