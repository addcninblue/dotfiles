if !has('nvim-0.5.0')
	finish
endif

" limelight
let g:limelight_conceal_ctermfg = 240

" camelcasemotion
call camelcasemotion#CreateMotionMappings(',')
vmap ,w <Esc>l,bv,e
omap ,w :normal v,w<CR>

" ack.vim
let g:ackprg = 'ag --vimgrep'

" undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>:wincmd h<CR>

" vim-markdown
let g:markdown_fenced_languages = ['java', 'perl', 'html', 'python', 'bash=sh', 'c']
let g:markdown_enable_mappings = 0

" delimitmate
let delimitMate_expand_cr = 1

" vim-sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>

" completion-nvim
let g:completion_enable_snippet = 'UltiSnips'
autocmd BufEnter * lua require'completion'.on_attach() " TODO: FIGURE OUT WHATS HAPPENING HERE

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" nerdtree {{{
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
" nerdtree }}}

" Calendar.vim {{{
nnoremap <leader>nc :Calendar<CR>
" Calendar.vim }}}

set tags=./tags,tags;$HOME

" fzf
if filereadable("/home/addison/.fzf/plugin/fzf.vim")
    source ~/.fzf/plugin/fzf.vim
    let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'fg', 'border': 'sharp' } }
endif

" vim tmux runner (VTR)
let g:VtrStripLeadingWhitespace = 0

" vimtex
let g:vimtex_quickfix_enabled = 0
let g:vimtex_view_method = 'zathura'

" firenvim
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'firenvim',
            \ 'priority': 0,
            \ 'selector': 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
            \ 'takeover': 'always',
        \ },
        \ '.*notion\.so.*': { 'priority': 9, 'takeover': 'never', },
        \ '.*docs\.google\.com.*': { 'priority': 9, 'takeover': 'never', },
    \ }
\ }

packadd nvim-treesitter
packadd nvim-lspconfig
packadd completion-nvim
" packadd popup.nvim
" packadd plenary.nvim
" packadd telescope.nvim

if filereadable("/home/addison/.fzf/plugin/fzf.vim")
    source ~/.fzf/plugin/fzf.vim
    let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'fg', 'border': 'sharp' } }
endif

sign define LspDiagnosticsErrorSign text=✗ texthl=LspDiagnosticsError linehl= numhl=
sign define LspDiagnosticsWarningSign text=‼ texthl=LspDiagnosticsWarning linehl= numhl=
sign define LspDiagnosticsInformationSign text=I texthl=LspDiagnosticsInformation linehl= numhl=
sign define LspDiagnosticsHintSign text=H texthl=LspDiagnosticsHint linehl= numhl=

" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
      },
    }
  },
}

require'lspconfig'.ccls.setup{}

require'lspconfig'.pyls.setup {
  settings = {
    pyls = {
      plugins = {
        pycodestyle = {
          enabled = false;
        }
      }
    }
  }
}

require'lspconfig'.elixirls.setup{
  cmd = { "/home/addison/.local/bin/elixir-ls/release/language_server.sh" },
  settings = {
    elixirLS = {
      dialyzerEnabled = false;
    }
  }
}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.vimls.setup{}

require'lspconfig'.rnix.setup{}

-- require'lspconfig'.r_language_server.setup{}

require'lspconfig'.bashls.setup{}

require'lspconfig'.texlab.setup{}

-- local actions = require('telescope.actions')
--
-- require'telescope'.setup {
--   defaults = {
--     mappings = {
--       i = {
-- 	["<C-j>"] = actions.move_selection_next,
-- 	["<C-k>"] = actions.move_selection_previous,
--       },
--     },
--   },
-- }
EOF
