" No compatibility – necessary for mappings to work.
set nocompatible

" Status line
set laststatus=0
set cmdheight=1
set nomodifiable " Only in version 6.0
set readonly

" My xterms have a navy-blue background, so I need this line too.
set background=dark

" Turn syntax on
syntax enable

" No menu bar and tool bar
set guioptions=aiMr

cnoremap q q!
nnoremap q :q!<CR>
