(lambda file-readable? [path]
  "Check that file is readable."
  (= 1 (vim.fn.filereadable (vim.fn.expand path))))

;;;; OPTIONS

(vim.cmd "filetype indent plugin on")
(vim.cmd "syntax on")
(set vim.g.mapleader " ") ;; space for leader
(vim.cmd "packloadall")
(vim.cmd "silent! helptags ALL")
(vim.cmd "colorscheme solarized")
(set vim.g.solarized_contrast "high")
(set vim.o.background "dark")

(vim.cmd "highlight Normal ctermbg=NONE")
(vim.cmd "highlight nonText ctermbg=NONE")
(vim.cmd "highlight SpecialKey ctermbg=NONE")
(vim.cmd "highlight LineNr ctermbg=NONE")
(vim.cmd "highlight SignColumn ctermbg=NONE")
(vim.cmd "highlight Comment cterm=italic gui=italic")

(vim.cmd "highlight Normal guibg=#002b36")
(vim.cmd "highlight nonText guibg=#002b36")
(vim.cmd "highlight SpecialKey guibg=#002b36")
(vim.cmd "highlight LineNr guibg=#002b36")
(vim.cmd "highlight SignColumn guibg=#002b36")

;; status bar color
(vim.cmd "highlight StatusLine ctermbg=12 ctermfg=8")
(vim.cmd "highlight VertSplit ctermbg=NONE")
(vim.cmd "highlight StatusLine guibg=#002b36 guifg=#eee8d5")
(vim.cmd "highlight VertSplit guibg=#002b36")
(vim.cmd "highlight CursorLineNr guifg=#eee8d5")

(set vim.o.backspace "indent,eol,start")      ; sane backspace
; (set vim.o.number true)                       ; shows line number on current line
; (set vim.o.relativenumber true)               ; shows relative line numbers on all other lines
(vim.cmd "set number")                       ; TODO: broken
(vim.cmd "set relativenumber")               ; TODO: broken
(set vim.o.hlsearch true)                     ; highlight items matching in search
(set vim.o.incsearch true)                    ; go to next matching item while typing
(set vim.o.inccommand "nosplit")              ; live substitution
(set vim.o.ignorecase true)                   ; ignore case while searching all lowercase
(set vim.o.smartcase true)                    ; allow cases where there are uppercase
(set vim.o.breakindent true)                  ; if wraps, same indent
; (set vim.o.foldlevel 99)                      ; no folds on start
(vim.cmd "set foldlevel=99") ; TODO: broken
; (set vim.o.noshowcmd true)                     ; show command
; (set vim.o.noshowmode true)                    ; show command
(vim.cmd "set noshowcmd")                     ; TODO: broken
(vim.cmd "set noshowmode")                    ; TODO: broken
(set vim.o.hidden true)                       ; no write on last edit
(set vim.o.sidescroll 1)                      ; scroll individually, not as a chunk
(set vim.o.lazyredraw true)                   ; redraws after all macros completed             ; lots faster
; (set vim.o.signcolumn "yes")
(vim.cmd "set signcolumn=yes") ; TODO: broken
; (set vim.o.nowrap true)
(vim.cmd "set nowrap")                        ; TODO: broken

(set vim.o.wildmenu true)                     ; allows for tab completion on edits
; (set vim.o.list true)
(vim.cmd "set list")                          ; TODO: broken
(set vim.o.undofile true)                     ; Save undo's after file closes
(set vim.o.undodir "$HOME/.config/nvim/undo") ; where to save undo histories
(set vim.o.undolevels 1000)                   ; How many undos
(set vim.o.undoreload 10000)                  ; number of lines to save for undo
; (set vim.o.listchars "nbsp:␣,extends:>,precedes:<,trail:·") ; for setting nonprinting characters
(set vim.o.listchars "tab:  ,nbsp:␣,extends:>,precedes:<,eol: ,trail:·") ; for setting nonprinting characters

(set vim.g.currentmode {"n" "NORMAL"
                        "no" "N·OPERATOR PENDING"
                        "v" "VISUAL"
                        "V" "V·LINE"
                        "" "V·BLOCK"
                        "s" "SELECT"
                        "S" "S·LINE"
                        "" "S·BLOCK"
                        "i" "INSERT"
                        "R" "REPLACE"
                        "Rv" "V·REPLACE"
                        "c" "COMMAND"
                        "cv" "VIM EX"
                        "ce" "EX"
                        "r" "PROMPT"
                        "rm" "MORE"
                        "r?" "CONFIRM"
                        "!" "SHELL"
                        "t" "TERMINAL"})

; TODO: rewrite as lua/fennel
(vim.api.nvim_exec "
function! Filetype()
	if &filetype == ''
		return ''
	else
		return '[' . &filetype . '] '
	endif
endfunction
" false)

; (set vim.o.noruler true)
(vim.cmd "set noruler")                     ; TODO: broken
(set vim.o.laststatus 2)
(set vim.o.statusline (.. "[%{g:currentmode[mode()]}]"
                          " %.40t"
                          "%="            ; Switch to the right side
                          "%m "           ; Modified
                          "%{Filetype()}" ; Filetype
                          "[%3l/%L] "     ; line of lines
                          "[%3p%%] "      ; percentage
                          ))

(set vim.o.mouse "a")
(set vim.o.splitright true)
(set vim.g.previewheight (vim.fn.floor (/ (vim.fn.winwidth 0) 2)))


;; Keybindings
(vimp.nnoremap "<leader>l" ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h ")
(vimp.cnoremap "w!!" "w suda://%")

;; ; <=> :
(vimp.nnoremap ":" ";")
(vimp.nnoremap ";" ":")
(vimp.vnoremap ":" ";")
(vimp.vnoremap ";" ":")

;; jk to escape
(vimp.inoremap "jk" "<ESC>")
(vimp.cnoremap "jk" "<ESC>")
(vimp.vnoremap "jk" "<ESC>")

;; switching tabs
(vimp.nnoremap "<leader>j" "gt")
(vimp.nnoremap "<leader>k" "gT")

;; X clipboard; Y -> y$
(vimp.nnoremap "<leader>y" "\"+y")
(vimp.nnoremap "<leader>Y" "\"+y$")
(vimp.nnoremap "<leader>p" "\"+p")
(vimp.nnoremap "<leader>P" "\"+P")
(vimp.vnoremap "<leader>y" "\"+y")
(vimp.vnoremap "<leader>Y" "\"+y$")
(vimp.nnoremap "Y" "y$")

;; change linebreak
(vimp.nnoremap "yoe" ":set linebreak!<CR>")

;;;; MAKE AND RUN
(vimp.nnoremap ["silent"] "<leader>r"
               (lambda []
                 (let [command (let [filetype (vim.api.nvim_eval "&filetype")
                                    filename (vim.fn.expand "%")
                                    filename-no-ext (vim.fn.expand "%<")] ; TODO: fix this in future when option works
                                (if
                                  (= filetype "c")
                                  (.. "gcc -o " filename-no-ext " " filename " && ./" filename-no-ext)
                                  (= filetype "perl")
                                  (.. "python3 " filename)
                                  (= filetype "java")
                                  (.. "java " filename-no-ext)
                                  (= filetype "sh")
                                  (.. "./ " filename)
                                  (= filetype "python")
                                  (.. "python3 " filename)
                                  (= filetype "html")
                                  (.. "!google-chrome-beta " filename " &")
                                  (= filetype "go")
                                  ":GoRun" ; TODO: Does this still work?
                                  (= filetype "haskell")
                                  (.. "runhaskell " filename)
                                  (= filetype "tex")
                                  (.. "zathura " filename-no-ext ".pdf")
                                  (= filetype "elixir")
                                  (.. "elixir " filename)
                                  (= filetype "r")
                                  (.. "Rscript " filename)
                                  (= filetype "lua")
                                  (.. "lua " filename)
                                  nil))]
                   (if command
                     (vim.cmd (.. "!tmux split-window -v -p 20 '" command " |& nvim -u ~/.config/nvim/ftplugin/more.vim -'"))
                     (print "not supported yet!")))))

(vimp.nnoremap ["silent"] "<leader>i"
               (lambda []
                 (let [command (let [filetype (vim.api.nvim_eval "&filetype")
                                     filename (vim.fn.expand "%")
                                     filename-no-ext (vim.fn.expand "%<")] ; TODO: fix this in future when option works
                                 (if (= filetype "python")
                                   (.. "python3 -i " filename)
                                   (= filetype "elixir")
                                   (.. "iex " filename)
                                   (= filetype "r")
                                   (.. "R --no-save")
                                   (= filetype "scheme")
                                   (.. "python3 scheme -i " filename)
                                   (= filetype "lua")
                                   (.. "lua -i " filename)
                                   nil))]
                   (if command
                     (vim.cmd (.. "!tmux split-window -v -p 20 " command))
                     (print "not supported yet!")))))

;;;; PLUGIN BINDINGS AND SETTINGS

;; FZF
(let (fzf-path "~/.fzf/plugin/fzf.vim")
  (when (file-readable? fzf-path)
    (vim.api.nvim_command (.. "source " fzf-path))
    (set vim.g.fzf_layout {"up" "~90%"
                           "window" {"width" 0.8
                                     "height" 0.8
                                     "yoffset" 0.5
                                     "xoffset" 0.5
                                     "highlight" "fg"
                                     "border" "sharp" }})
    (vimp.nnoremap "<C-p>" ":FZF<CR>")
    (vimp.nnoremap "<C-b>" ":Buffers<CR>")
    (vimp.nnoremap "<leader>gg" ":Rg<CR>")))

;; vim tmux runner (VTR)
(vimp.nnoremap "<leader>va" ":VtrAttachToPane<CR>")
(vimp.nnoremap "<leader>vs" ":VtrSendLinesToRunner<CR>")
(vimp.vnoremap "<leader>vs" ":VtrSendLinesToRunner<CR>")
(set vim.g.VtrStripLeadingWhitespace 0)

;; vimtex
(set vim.g.vimtex_quickfix_enabled 0)
(set vim.g.vimtex_view_method "zathura")

;; limelight
(vim.api.nvim_set_var "limelight_conceal_ctermfg" 240)

;; camelcasemotion
(vim.call "camelcasemotion#CreateMotionMappings" ",")
(vimp.omap ",iw" "<Plug>CamelCaseMotion_iw")
(vimp.xmap ",iw" "<Plug>CamelCaseMotion_iw")
(vimp.omap ",ib" "<Plug>CamelCaseMotion_ib")
(vimp.xmap ",ib" "<Plug>CamelCaseMotion_ib")
(vimp.omap ",ie" "<Plug>CamelCaseMotion_ie")
(vimp.xmap ",ie" "<Plug>CamelCaseMotion_ie")

;; Undotree
(vimp.nnoremap "<leader>u" ":UndotreeToggle<CR>:wincmd h<CR>")

;; delimitmate
(set vim.g.delimitMate_expand_cr 1)

;; Nerdtree
(vimp.nnoremap "<leader>nn" ":NERDTreeToggle<CR>")
(vimp.nnoremap "<leader>nf" ":NERDTreeFind<CR>")
(set vim.g.NERDTreeShowLineNumbers 1)
(vim.api.nvim_exec "autocmd FileType nerdtree setlocal relativenumber" false)

;; Calendar.vim
(vimp.nnoremap "<leader>nc" ":Calendar")

;; Set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noinsert,noselect")

;; Avoid showing message extra message when using completion
(set vim.o.shortmess (.. vim.o.shortmess "IaT"))

;;;; VIMWIKI

(set vim.g.vimwiki_list [{"path" "~/vimwiki/"
                          "syntax" "markdown"
                          "ext" ".md"
                          "auto_diary_index" 1
                          "auto_tags" 1}])
(set vim.g.vimwiki_global_ext 0)
(vim.call "vimwiki#vars#init")

;;;; LSP
(vim.fn.sign_define "LspDiagnosticsErrorSign" {"text" "✗" "texthl" "LspDiagnosticsError" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsWarningSign" {"text" "‼" "texthl" "LspDiagnosticsWarning" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsInformationSign" {"text" "I" "texthl" "LspDiagnosticsInformation" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsHintSign" {"text" "H" "texthl" "LspDiagnosticsHint" "linehl" "" "numhl" ""})

;; (vimp.nnoremap "K"    vim.lsp.buf.hover) ; TODO: LOOK AT THIS
(vimp.nnoremap "K"    "<cmd>lua vim.lsp.buf.hover()<CR>")
(vimp.nnoremap "gD"   "<cmd>lua vim.lsp.buf.implementation()<CR>")
(vimp.nnoremap "1gD"  "<cmd>lua vim.lsp.buf.type_definition()<CR>")
(vimp.nnoremap "gr"   "<cmd>lua vim.lsp.buf.references()<CR>")
(vimp.nnoremap "g0"   "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
(vimp.nnoremap "gW"   "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
(vimp.nnoremap "gd"   "<cmd>lua vim.lsp.buf.definition()<CR>")

(let [configs (require "nvim-treesitter.configs")]
  (configs.setup {"ensure_installed" "all"
                  "highlight" {"enable" true}
                  "refactor" {"navigation" {"enable" true}}}))
(let [lspconfig (require "lspconfig")]
  (lspconfig.ccls.setup {})
  (lspconfig.pyls.setup {"settings" {"pyls" {"plugins" {"pycodestyle" {"enabled" false}}}}})
  (lspconfig.elixirls.setup {"cmd" "/home/addison/.local/bin/elixir-ls/release/language_server.sh"
                             "settings" {"elixirLS" {"dialyzerEnabled" false}}})
  (lspconfig.tsserver.setup {})
  (lspconfig.vimls.setup {})
  (lspconfig.rnix.setup {})
  ; (lspconfig.r_language_server.setup {}) ; broken
  (lspconfig.bashls.setup {})
  (lspconfig.texlab.setup {}))

nil
