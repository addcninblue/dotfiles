setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent

nnoremap <silent><F5> :!clear;javac % <CR>
nnoremap <silent><F6> :!clear;java -cp %:p:h %:t:r<CR>

nnoremap <silent><F2> :!/usr/lib/eclipse/plugins/org.eclim_2.6.0/bin/eclimd&
nnoremap <silent><F3> :ShutdownEclim
