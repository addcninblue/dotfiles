" nnoremap <silent><leader>m :make<CR><CR>
nnoremap <silent><leader>mm :call Make()<CR>
nnoremap <silent><leader>mc :exec "!clear;make clean"<CR>
nnoremap <silent><leader>mt :exec "!clear;make test"<CR>
" nnoremap <silent><leader>mr :exec "!clear;ghc % -odir ../out -hidir ../out -o ../%:r && ../%:r && rm -r ../out"<CR>
nnoremap <silent><leader>mf :exec "!make"
nnoremap <silent><leader>mr :call Make()<CR> :call Run()<CR>
let g:javaCommand = "Asyncrun make clean && make"
func! Make()
	if &filetype == 'java'
		exec "!clear;javac %"
		" let l:command="javac " . expand("%")
		" silent exec "!tmux split-window -v -p 20 '" . l:command . " | less'"
		" exec "Dispatch javac %"
	" if &filetype == 'java'
	" 	exec "AsyncRun make clean && make"
	" if &filetype == 'java'
	" 	exec "!javac %"
	elseif &filetype == 'markdown'
		exec ":w"
		exec "AsyncRun pandoc % -o %<.pdf && zathura %<.pdf"
	elseif &filetype == 'tex'
		exec ":w"
		silent exec "!latexmk -pdf %"
		silent exec "!latexmk -c"
		" exec "normal!\<CR>"
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
nnoremap <leader>i :call Interactive()<CR><CR>
func! Run()
	let l:command="echo 'not a function'"
	if &filetype == 'c'
		let l:command="gcc -o " . expand("%:r") . " " . expand("%") . " && ./" . expand("%:r")
		" exec "!gcc % -o %<"
	" 	exec "!time ./%<"
	" elseif &filetype == 'cpp'
	" 	exec "!g++ % -o %<" " 	exec "!time ./%<"
	elseif &filetype == 'perl'
		let l:command="perl " . expand("%")
	elseif &filetype == 'java'
		let l:command="java ". expand("%:r")
	elseif &filetype == 'sh'
		let l:command="./" . expand("%")
	elseif &filetype == 'python'
		let l:command="python " . expand("%")
	elseif &filetype == 'html'
		exec "!google-chrome-beta % &"
	elseif &filetype == 'go'
		exec ":GoRun"
	elseif &filetype == 'haskell'
		let l:command="runhaskell " . expand("%")
	elseif &filetype == 'tex'
		let l:command="zathura " . expand("%<") . ".pdf"
	endif
	silent exec "!tmux split-window -v -p 20 '" . l:command . " |& nvim -u ~/.config/nvim/ftplugin/more.vim -'"
	" silent exec "!tmux split-window -v -p 20 '" . l:command . " |& less'"
endfunc
func! Interactive()
	let l:command="echo 'not a function'"
	if &filetype == 'python'
		let l:command="python -i " .expand("%")
	endif
	exec "!tmux split-window -v -p 20 " . l:command
endfunc
