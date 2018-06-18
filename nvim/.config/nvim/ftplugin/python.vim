setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent

" plugins
" packadd python-mode
" packadd codi
packadd ale

" Opens Python documentation on <S-k>
nnoremap <buffer> K :<C-u>execute "!pydoc " . expand("<cword>")<CR>
