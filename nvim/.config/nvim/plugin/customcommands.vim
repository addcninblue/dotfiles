function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" http://ddrscott.github.io/blog/2016/bs-to-the-black-hole/
func! BlackHoleDeleteOperator(type)
  if a:type ==# 'char'
    execute 'normal! `[v`]"_d'
  elseif a:type ==# 'line'
    execute 'normal! `[V`]"_d'
  else
    execute 'normal! `<' . a:type . '`>"_d'
  endif
endf

" Map to <BS> because it's under worked in Vim.
nnoremap <silent> <BS> <Esc>:set opfunc=BlackHoleDeleteOperator<CR>g@
vnoremap <silent> <BS> :<C-u>call BlackHoleDeleteOperator(visualmode())<CR>

" function! RangerExplorer()
"     exec "!ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
"     if filereadable('/tmp/vim_ranger_current_file')
"         exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
"         call system('rm /tmp/vim_ranger_current_file')
"     endif
"     redraw!
" endfun
" nnoremap <Leader>x :call RangerExplorer()<CR>
