(vim.cmd "packadd packer.nvim")
(set vim.g.NERDTreeMapHelp "")  ; Disable ? in NERDTree. This has to go before it's loaded.
(let [packer (require "packer")]
  (packer.startup
    (fn []
      (use "wbthomason/packer.nvim")
      (use "bkad/CamelCaseMotion")
      (use "Raimondi/delimitMate")
      (use "wellle/targets.vim")
      (use "mbbill/undotree")
      (use "tpope/vim-commentary")
      (use "tpope/vim-repeat")
      (use "tpope/vim-surround")
      (use "christoomey/vim-tmux-navigator")
      (use "tpope/vim-unimpaired")
      (use "junegunn/fzf.vim")
      (use "preservim/nerdtree")
      ; (use "tpope/vim-liquid")
      (use "vimwiki/vimwiki")
      ; (use "mattn/calendar-vim")
      (use "lambdalisue/suda.vim")
      (use {1 "nvim-treesitter/nvim-treesitter"
            :run ":TSUpdate"
            :commit "46dc8b8f40d506fa9267b63dac3faa95fd866362"})
      (use "tpope/vim-fugitive")
      (use "neovim/nvim-lspconfig")
      (use "svermeulen/vimpeccable")
      (use "nvim-lua/lsp-status.nvim")
      (use {1 "RishabhRD/nvim-lsputils"
            :requires [["RishabhRD/popfix"]]})
      (use "nathangrigg/vim-beancount")
      (use "JuliaEditorSupport/julia-vim")
      (use "tpope/vim-rhubarb")
      (use "sirtaj/vim-openscad")
      (use "junegunn/vim-easy-align")
      ; (use "jamestthompson3/nvim-remote-containers")
      (use "lewis6991/gitsigns.nvim")

      (use "addcninblue/nvim-runner")
      (use "addcninblue/nvim-acmetag")
      ; (use "addcninblue/scratch.vim")
      (use "/home/addison/xps-dotfiles/nvim/.config/nvim/pack/bundle/old_start/nvim-scratch")

      (use {1 "hrsh7th/nvim-cmp"
            :commit "bb5cac4dcec3bc6ba3b569e83feeedf5c58f466c"})
      ; (use "hrsh7th/cmp-cmdline")
      (use "hrsh7th/cmp-buffer")
      (use "hrsh7th/cmp-path")
      (use "hrsh7th/cmp-nvim-lua")
      (use "hrsh7th/cmp-nvim-lsp")
      (use "hrsh7th/cmp-nvim-lsp-document-symbol")
      ; (use "saadparwaiz1/cmp_luasnip")
      (use "tamago324/cmp-zsh")

      (use "lark-parser/vim-lark-syntax")
)))

(global UNNAMED-REGISTER "\"")

(lambda file-readable? [path]
  "Check that file is readable."
  (= 1 (vim.fn.filereadable (vim.fn.expand path))))

(lambda open-split [command]
  "Opens bottom split terminal at 20% height with given command."
  (let [bufheight (vim.fn.floor (/ (vim.fn.winheight 0) 5))]
    (vim.cmd (.. "belowright " bufheight "split term://" command))))

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
(set vim.wo.number true)                       ; shows line number on current line
(set vim.wo.relativenumber true)               ; shows relative line numbers on all other lines
(set vim.o.hlsearch true)                     ; highlight items matching in search
(set vim.o.incsearch true)                    ; go to next matching item while typing
(set vim.o.inccommand "split")                ; live substitution
(set vim.o.ignorecase true)                   ; ignore case while searching all lowercase
(set vim.o.smartcase true)                    ; allow cases where there are uppercase
(set vim.o.breakindent true)                  ; if wraps, same indent
(set vim.o.foldlevel 99)                      ; no folds on start
; (vim.cmd "set foldlevel=99") ; TODO: broken
(set vim.o.showcmd false)                     ; show command
(set vim.o.showmode false)                    ; show command
(set vim.o.hidden true)                       ; no write on last edit
(set vim.o.sidescroll 1)                      ; scroll individually, not as a chunk
(set vim.o.lazyredraw true)                   ; redraws after all macros completed             ; lots faster
(set vim.wo.signcolumn "yes")
(set vim.wo.wrap false)
(set vim.o.equalalways false)                 ; no resize on window exit

(set vim.o.wildmenu true)                     ; allows for tab completion on edits
(set vim.wo.list true)
(set vim.o.undofile true)                     ; Save undo's after file closes
(set vim.o.undodir (vim.fn.expand "~/.config/nvim/undo")) ; where to save undo histories
(set vim.o.undolevels 1000)                   ; How many undos
(set vim.o.undoreload 10000)                  ; number of lines to save for undo
; (set vim.o.listchars "nbsp:␣,extends:>,precedes:<,trail:·") ; for setting nonprinting characters
(set vim.o.listchars "tab:  ,nbsp:␣,extends:…,precedes:<,eol: ,trail:·") ; for setting nonprinting characters

(var modetable {"n" "NORMAL"
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

(lambda _G.statusline []
  (let [filetype (vim.api.nvim_buf_get_option 0 "filetype")
        mode (. (vim.api.nvim_get_mode) "mode")
        currentmode (or (. modetable mode) "OTHER")
        half-width (vim.fn.floor (/ (vim.fn.winwidth 0) 2))
        lspstatus (if (and (> (# (vim.lsp.buf_get_clients)) 0) (> (# (vim.lsp.diagnostic.get_line_diagnostics)) 0))
                    (let [lsp-status (require "lsp-status")
                          message (. (. (vim.lsp.diagnostic.get_line_diagnostics) 1) "message")]
                      (.. "[" (string.sub message 1 half-width) "] "))
                    ""
                    )]
    (.. "[" currentmode "]" ; Vim Mode
        " %.40t"            ; Filename
        " " lspstatus
        "%="                ; Switch to the right side
        "%m "               ; Modified
        "[" filetype "] "   ; Filetype
        "[%3l/%L] "         ; line of lines
        "[%3p%%] ")         ; percentage
    ))
(set vim.o.statusline "%!v:lua.statusline()")
(vim.cmd "set noruler")                     ; TODO: broken
(set vim.o.laststatus 3)

(set vim.o.mouse "a")
(set vim.o.splitright true)
(set vim.g.previewheight (vim.fn.floor (/ (vim.fn.winwidth 0) 2)))
(set vim.g.do_filetype_lua 1)
(set vim.g.did_load_filetypes 0)

(vim.filetype.add {:extension {:md "markdown"}})


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
(vimp.tnoremap "jk" "<C-\\><C-n>")

;; switching tabs
(vimp.nnoremap "<leader>j" "gt")
(vimp.nnoremap "<leader>k" "gT")
(vimp.nnoremap "<leader>1" "1gt")
(vimp.nnoremap "<leader>2" "2gt")
(vimp.nnoremap "<leader>3" "3gt")
(vimp.nnoremap "<leader>4" "4gt")
(vimp.nnoremap "<leader>5" "5gt")
(vimp.nnoremap "<leader>6" "6gt")
(vimp.nnoremap "<leader>7" "7gt")
(vimp.nnoremap "<leader>8" "8gt")
(vimp.nnoremap "<leader>9" ":tablast<CR>")

;; X clipboard; Y -> y$
(vimp.nnoremap "<leader>y" "\"+y")
(vimp.nnoremap "<leader>Y" "\"+y$")
(vimp.nnoremap "<leader>p" "\"+p")
(vimp.nnoremap "<leader>P" "\"+P")
(vimp.vnoremap "<leader>y" "\"+y")
(vimp.vnoremap "<leader>Y" "\"+y$")

;; change linebreak
(vimp.nnoremap "yoe" ":set linebreak!<CR>")

;;;; Vim-Acmetag
(let [letters [ "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" ]
      acmetag (require "acmetag")]
  (each [_ letter (ipairs letters)]
    (vimp.nnoremap ["silent"] (.. "-" letter)
                   (lambda [] (acmetag.run letter))))
  (vimp.nnoremap ["silent"] "--" acmetag.display_registers)
  (vimp.nnoremap ["silent"] "- " acmetag.yank_line_to_register))

;;;; MAKE AND RUN
(set vim.go.virtualedit "block,onemore")
(let [runner (require "runner")]
  (vimp.nnoremap ["silent"] "<leader>r" runner.run)
  (vimp.nnoremap ["silent"] "<leader>i" runner.interactive)
  (vimp.nnoremap ["silent" "expr"] "<leader>-" runner.send_text)
  (vimp.vnoremap ["silent" "expr"] "<leader>-" runner.send_text))

(lambda get-filepath []
  "Returns filepath:row:col"
  (let [filename (vim.api.nvim_buf_get_name 0)
        line (vim.fn.line ".")
        col (vim.fn.col ".")]
    (.. filename ":" line ":" col)))

(lambda save-error-message []
  "Save error message to unnamed register as filepath:row:col: comment"
  (vim.fn.setreg UNNAMED-REGISTER (.. (get-filepath) ": " (vim.fn.input "Comment > "))))

(vimp.nnoremap ["silent"] "<leader><C-G>" save-error-message)

(lambda trim-end [line end-pos]
  "Trims line until end-pos, inclusive"
  (: "sub" 1 end-pos))

(lambda trim-start [line start-pos]
  "Trims line until start-pos, inclusive"
  (: "sub" start-pos))

(lambda replace-line [lines line-num operation]
  (tset lines line-num (operation (. lines line-num))))

(lambda get-visual-selection []
  "Returns list of visual selection"
  (let [(_ line-start column-start _) (unpack (vim.fn.getpos "'<"))
        (_ line-end column-end _) (unpack (vim.fn.getpos "'>"))
        lines (vim.fn.getline line-start line-end)]
    (->
      (if (= (length lines) 0)
        lines
        (do
          (replace-line lines 1 trim-start)
          (tset lines 1 (: (. lines 1) "sub" column-start))
          (tset lines (length lines) (: (. lines (length lines)) "sub" 1 column-end))
          lines))
      (table.concat ", ")
      (print)
      )))
    

vim.o.selection

(vimp.vnoremap ["silent"] "<leader>e" get-visual-selection)
(vimp.vnoremap ["silent"] "<leader>w" (lambda [] (print (vim.fn.mode))))


;;;; PLUGIN BINDINGS AND SETTINGS

;; FZF
(let [fzf-path "~/.fzf/plugin/fzf.vim"]
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
    (vimp.nnoremap "<C-[>" ":GFiles<CR>")
    (vimp.nnoremap "<C-b>" ":Buffers<CR>")
    (vimp.nnoremap "<leader>gg" ":Rg<CR>")))

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
(set vim.g.NERDTreeMinimalUI 1)
(set vim.g.NERDTreeMarkBookmarks 0)
(set vim.g.NERDTreeMapHelp "")
(vim.api.nvim_exec "autocmd FileType nerdtree setlocal relativenumber" false)

;; Calendar.vim
(vimp.nnoremap "<leader>nc" ":Calendar")

;; Set completeopt to have a better completion experience
(set vim.o.completeopt "menu,menuone,noinsert,noselect")

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

;; taskwiki
(set vim.g.taskwiki_disable_concealcursor "yes") ; Show metadata in line

;;;; LSP
(vim.fn.sign_define "LspDiagnosticsErrorSign" {"text" "✗" "texthl" "LspDiagnosticsError" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsWarningSign" {"text" "‼" "texthl" "LspDiagnosticsWarning" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsInformationSign" {"text" "I" "texthl" "LspDiagnosticsInformation" "linehl" "" "numhl" ""})
(vim.fn.sign_define "LspDiagnosticsHintSign" {"text" "H" "texthl" "LspDiagnosticsHint" "linehl" "" "numhl" ""})

(vimp.nnoremap "K"    vim.lsp.buf.hover)
; (vimp.nnoremap "gs" vim.lsp.buf.signature_help)
; (vimp.nnoremap "gD"   vim.lsp.buf.implementation)
; (vimp.nnoremap "1gD"  vim.lsp.buf.type_definition)
(vimp.nnoremap "gr"   vim.lsp.buf.references)
(vimp.nnoremap "g0"   vim.lsp.buf.document_symbol)
(vimp.nnoremap "gW"   vim.lsp.buf.workspace_symbol)
(vimp.nnoremap "gd"   vim.lsp.buf.definition)
(vimp.nnoremap ["override"] "[e"   vim.diagnostic.goto_prev)
(vimp.nnoremap ["override"] "]e"   vim.diagnostic.goto_next)
(vimp.nnoremap "<leader>f" vim.lsp.buf.formatting)

; local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
; parser_config.zimbu = {
;   install_info = {
;     url = "~/projects/tree-sitter-zimbu", -- local path or git repo
;     files = {"src/parser.c"}
;   },
;   filetype = "zu", -- if filetype does not agrees with parser name
;   used_by = {"bar", "baz"} -- additional filetypes that use this parser
; }

; (let [parsers (require "nvim-treesitter.parsers")
;       parser-config (parsers.get_parser_configs)]
;   (set parser-config.cooklang {"install_info" {"url" "~/stuff/tree-sitter-cooklang"
;                                                "files" ["src/parser.c" "src/scanner.cc"]}
;                                "filetype" "cook"}))

(let [configs (require "nvim-treesitter.configs")]
  (configs.setup {:ensure_installed "maintained"
                  :sync_install "false"
                  :ignore_install ["norg"]
                  :highlight {"enable" true}
                  :refactor {"navigation" {"enable" true}}
                  :additional_vim_regex_highlighting false}))
(let [lspconfig (require "lspconfig")]
  (lspconfig.ccls.setup {})
  ; (lspconfig.pylsp.setup {})
  (lspconfig.pylsp.setup {"settings" {"pylsp" {"plugins" {"pycodestyle" {"maxLineLength" 120}
                                                                         ; "enabled" false}
                                                          ;"pycodestyle" {"enabled" false}
                                                          ; "pyflakes" {"enabled" false}
                                                          "flake8" {"ignore" ["F405"]
                                                                    "maxLineLength" 120}
                                                          }}}})
  ; (lspconfig.elixirls.setup {"cmd" ["/home/addison/.local/bin/elixir-ls/release/language_server.sh"] ; Disables dialyzer
  ;                            "settings" {"elixirLS" {"dialyzerEnabled" false}}})
  (lspconfig.elixirls.setup {"cmd" ["/home/addison/.local/bin/elixir-ls/release/language_server.sh"]})
  (lspconfig.tsserver.setup {})
  (lspconfig.vimls.setup {})
  (lspconfig.rnix.setup {})
  ; (lspconfig.r_language_server.setup {}) ; broken
  (lspconfig.bashls.setup {})
  (lspconfig.texlab.setup {})
  (lspconfig.ccls.setup {})
  (lspconfig.julials.setup {})
  (lspconfig.rust_analyzer.setup {}))

; ;; nvim-lsputils
; (let [codeAction (require "lsputil.codeAction")
;       locations (require "lsputil.locations")
;       symbols (require "lsputil.symbols")]
;     (tset vim.lsp.handlers "textDocument/codeAction" codeAction.code_action_handler)
;     (tset vim.lsp.handlers "textDocument/references" locations.references_handler)
;     (tset vim.lsp.handlers "textDocument/definition" locations.definition_handler)
;     (tset vim.lsp.handlers "textDocument/declaration" locations.declaration_handler)
;     (tset vim.lsp.handlers "textDocument/typeDefinition" locations.typeDefinition_handler)
;     (tset vim.lsp.handlers "textDocument/implementation" locations.implementation_handler)
;     (tset vim.lsp.handlers "textDocument/documentSymbol" locations.document_handler)
;     (tset vim.lsp.handlers "workplace/symbol" symbols.workspace_handler))
;   ; (tset vim.lsp.handlers {"textDocument/codeAction" codeAction.code_action_handler
;   ;                        "textDocument/references"     locations.references_handler
;   ;                        "textDocument/definition"     locations.definition_handler
;   ;                        "textDocument/declaration"    locations.declaration_handler
;   ;                        "textDocument/typeDefinition" locations.typeDefinition_handler
;   ;                        "textDocument/implementation" locations.implementation_handler
;   ;                        "textDocument/documentSymbol" locations.document_handler
;   ;                        "workplace/symbol" symbols.workspace_handler}))
; ; vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
; ; vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
; ; vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
; ; vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
; ; vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
; ; vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
; ; vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

(vim.api.nvim_exec "autocmd BufWritePre *.ex,*.exs lua vim.lsp.buf.formatting_sync(nil, 1000)" false)

; ;; completion-nvim
; (set vim.g.completion_enable_snippet "Ultisnips")
; (vim.api.nvim_exec "autocmd BufEnter * lua require'completion'.on_attach()" false)

;; scratch.vim - I run my own custom patch
;; (set vim.g.scratch_autohide 0)
;; (set vim.g.scratch_insert_autohide 0)
;; (set vim.g.scratch_filetype "markdown")
;; (set vim.g.scratch_persistence_file ".scratch.vim")
;; (set vim.g.scratch_no_mappings 1)
;; (vimp.nnoremap ["override"] "gs" ":Scratch<CR>")
(let [scratch (require "scratch")]
  (vimp.nnoremap ["override" "silent"] "gss" scratch.open-last-scratchpad)
  (vimp.nnoremap ["override" "silent"] "gs." scratch.open-current-scratchpad)
  (vimp.nnoremap ["override" "silent"] "gse" scratch.open-scratchpad))

;; EasyAlign
(vimp.xmap "ga" "<Plug>(EasyAlign)")
(vimp.nmap "ga" "<Plug>(EasyAlign)")

;; nvim-cmp
(let [cmp (require "cmp")
      cmp-types (require "cmp.types")]
  (cmp.setup {:mapping (cmp.mapping.preset.insert {"<C-b>" (cmp.mapping (cmp.mapping.scroll_docs -4) ["i" "c"])
                                                   "<C-f>" (cmp.mapping (cmp.mapping.scroll_docs 4) ["i" "c"])
                                                   "<C-e>" (cmp.mapping {"i" (cmp.mapping.abort)
                                                                         "c" (cmp.mapping.close)})})
              :sources (cmp.config.sources [{:name "nvim_lsp"}
                                            {:name "path"}
                                            {:name "buffer" :keyword_length 5}])
              :experimental {:ghost_text true}
	      :preselect cmp.PreselectMode.None})
  (cmp.setup.cmdline "/" {:sources {:name "buffer"}}))

(let [gitsigns (require "gitsigns")] (gitsigns.setup {:numhl true
                                                      :current_line_blame false
                                                      :current_line_blame_opts {:delay 0}}))

nil
