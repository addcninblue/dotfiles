vim.cmd("packadd packer.nvim")
vim.g.NERDTreeMapHelp = ""
do
  local packer = require("packer")
  local function _1_()
    use("wbthomason/packer.nvim")
    use("bkad/CamelCaseMotion")
    use("Raimondi/delimitMate")
    use("wellle/targets.vim")
    use("mbbill/undotree")
    use("tpope/vim-commentary")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("christoomey/vim-tmux-navigator")
    use("tpope/vim-unimpaired")
    use("junegunn/fzf.vim")
    use("preservim/nerdtree")
    use("vimwiki/vimwiki")
    use("lambdalisue/suda.vim")
    use({run = ":TSUpdate", commit = "46dc8b8f40d506fa9267b63dac3faa95fd866362", "nvim-treesitter/nvim-treesitter"})
    use("tpope/vim-fugitive")
    use("neovim/nvim-lspconfig")
    use("svermeulen/vimpeccable")
    use("nvim-lua/lsp-status.nvim")
    use({requires = {{"RishabhRD/popfix"}}, "RishabhRD/nvim-lsputils"})
    use("nathangrigg/vim-beancount")
    use("JuliaEditorSupport/julia-vim")
    use("tpope/vim-rhubarb")
    use("sirtaj/vim-openscad")
    use("junegunn/vim-easy-align")
    use("lewis6991/gitsigns.nvim")
    use("addcninblue/nvim-runner")
    use("addcninblue/nvim-acmetag")
    use("/home/addison/xps-dotfiles/nvim/.config/nvim/pack/bundle/old_start/nvim-scratch")
    use({commit = "bb5cac4dcec3bc6ba3b569e83feeedf5c58f466c", "hrsh7th/nvim-cmp"})
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("tamago324/cmp-zsh")
    return use("lark-parser/vim-lark-syntax")
  end
  packer.startup(_1_)
end
__fnl_global__UNNAMED_2dREGISTER = "\""
local function file_readable_3f(path)
  _G.assert((nil ~= path), "Missing argument path on init.fnl:60")
  return (1 == vim.fn.filereadable(vim.fn.expand(path)))
end
local function open_split(command)
  _G.assert((nil ~= command), "Missing argument command on init.fnl:64")
  local bufheight = vim.fn.floor((vim.fn.winheight(0) / 5))
  return vim.cmd(("belowright " .. bufheight .. "split term://" .. command))
end
vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
vim.g.mapleader = " "
vim.cmd("packloadall")
vim.cmd("silent! helptags ALL")
vim.cmd("colorscheme solarized")
vim.g.solarized_contrast = "high"
vim.o.background = "dark"
vim.cmd("highlight Normal ctermbg=NONE")
vim.cmd("highlight nonText ctermbg=NONE")
vim.cmd("highlight SpecialKey ctermbg=NONE")
vim.cmd("highlight LineNr ctermbg=NONE")
vim.cmd("highlight SignColumn ctermbg=NONE")
vim.cmd("highlight Comment cterm=italic gui=italic")
vim.cmd("highlight Normal guibg=#002b36")
vim.cmd("highlight nonText guibg=#002b36")
vim.cmd("highlight SpecialKey guibg=#002b36")
vim.cmd("highlight LineNr guibg=#002b36")
vim.cmd("highlight SignColumn guibg=#002b36")
vim.cmd("highlight StatusLine ctermbg=12 ctermfg=8")
vim.cmd("highlight VertSplit ctermbg=NONE")
vim.cmd("highlight StatusLine guibg=#002b36 guifg=#eee8d5")
vim.cmd("highlight VertSplit guibg=#002b36")
vim.cmd("highlight CursorLineNr guifg=#eee8d5")
vim.o.backspace = "indent,eol,start"
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.breakindent = true
vim.o.foldlevel = 99
vim.o.showcmd = false
vim.o.showmode = false
vim.o.hidden = true
vim.o.sidescroll = 1
vim.o.lazyredraw = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false
vim.o.equalalways = false
vim.o.wildmenu = true
vim.wo.list = true
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.listchars = "tab:  ,nbsp:\226\144\163,extends:\226\128\166,precedes:<,eol: ,trail:\194\183"
local modetable = {n = "NORMAL", no = "N\194\183OPERATOR PENDING", v = "VISUAL", V = "V\194\183LINE", ["\22"] = "V\194\183BLOCK", s = "SELECT", S = "S\194\183LINE", ["\19"] = "S\194\183BLOCK", i = "INSERT", R = "REPLACE", Rv = "V\194\183REPLACE", c = "COMMAND", cv = "VIM EX", ce = "EX", r = "PROMPT", rm = "MORE", ["r?"] = "CONFIRM", ["!"] = "SHELL", t = "TERMINAL"}
_G.statusline = function()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local mode = vim.api.nvim_get_mode().mode
  local currentmode = (modetable[mode] or "OTHER")
  local half_width = vim.fn.floor((vim.fn.winwidth(0) / 2))
  local lspstatus
  if ((#vim.lsp.buf_get_clients() > 0) and (#vim.lsp.diagnostic.get_line_diagnostics() > 0)) then
    local lsp_status = require("lsp-status")
    local message = (vim.lsp.diagnostic.get_line_diagnostics()[1]).message
    lspstatus = ("[" .. string.sub(message, 1, half_width) .. "] ")
  else
    lspstatus = ""
  end
  return ("[" .. currentmode .. "]" .. " %.40t" .. " " .. lspstatus .. "%=" .. "%m " .. "[" .. filetype .. "] " .. "[%3l/%L] " .. "[%3p%%] ")
end
vim.o.statusline = "%!v:lua.statusline()"
vim.cmd("set noruler")
vim.o.laststatus = 3
vim.o.mouse = "a"
vim.o.splitright = true
vim.g.previewheight = vim.fn.floor((vim.fn.winwidth(0) / 2))
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
vim.filetype.add({extension = {md = "markdown"}})
vimp.nnoremap("<leader>l", ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h ")
vimp.cnoremap("w!!", "w suda://%")
vimp.nnoremap(":", ";")
vimp.nnoremap(";", ":")
vimp.vnoremap(":", ";")
vimp.vnoremap(";", ":")
vimp.inoremap("jk", "<ESC>")
vimp.cnoremap("jk", "<ESC>")
vimp.vnoremap("jk", "<ESC>")
vimp.tnoremap("jk", "<C-\\><C-n>")
vimp.nnoremap("<leader>j", "gt")
vimp.nnoremap("<leader>k", "gT")
vimp.nnoremap("<leader>1", "1gt")
vimp.nnoremap("<leader>2", "2gt")
vimp.nnoremap("<leader>3", "3gt")
vimp.nnoremap("<leader>4", "4gt")
vimp.nnoremap("<leader>5", "5gt")
vimp.nnoremap("<leader>6", "6gt")
vimp.nnoremap("<leader>7", "7gt")
vimp.nnoremap("<leader>8", "8gt")
vimp.nnoremap("<leader>9", ":tablast<CR>")
vimp.nnoremap("<leader>y", "\"+y")
vimp.nnoremap("<leader>Y", "\"+y$")
vimp.nnoremap("<leader>p", "\"+p")
vimp.nnoremap("<leader>P", "\"+P")
vimp.vnoremap("<leader>y", "\"+y")
vimp.vnoremap("<leader>Y", "\"+y$")
vimp.nnoremap("yoe", ":set linebreak!<CR>")
do
  local letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
  local acmetag = require("acmetag")
  for _, letter in ipairs(letters) do
    local function _3_()
      return acmetag.run(letter)
    end
    vimp.nnoremap({"silent"}, ("-" .. letter), _3_)
  end
  vimp.nnoremap({"silent"}, "--", acmetag.display_registers)
  vimp.nnoremap({"silent"}, "- ", acmetag.yank_line_to_register)
end
vim.go.virtualedit = "block,onemore"
do
  local runner = require("runner")
  vimp.nnoremap({"silent"}, "<leader>r", runner.run)
  vimp.nnoremap({"silent"}, "<leader>i", runner.interactive)
  vimp.nnoremap({"silent", "expr"}, "<leader>-", runner.send_text)
  vimp.vnoremap({"silent", "expr"}, "<leader>-", runner.send_text)
end
local function get_filepath()
  local filename = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  return (filename .. ":" .. line .. ":" .. col)
end
local function save_error_message()
  return vim.fn.setreg(__fnl_global__UNNAMED_2dREGISTER, (get_filepath() .. ": " .. vim.fn.input("Comment > ")))
end
vimp.nnoremap({"silent"}, "<leader><C-G>", save_error_message)
local function trim_end(line, end_pos)
  _G.assert((nil ~= end_pos), "Missing argument end-pos on init.fnl:252")
  _G.assert((nil ~= line), "Missing argument line on init.fnl:252")
  return (function(tgt, m, ...) return tgt[m](tgt, ...) end)("sub", 1, end_pos)
end
local function trim_start(line, start_pos)
  _G.assert((nil ~= start_pos), "Missing argument start-pos on init.fnl:256")
  _G.assert((nil ~= line), "Missing argument line on init.fnl:256")
  return (function(tgt, m, ...) return tgt[m](tgt, ...) end)("sub", start_pos)
end
local function replace_line(lines, line_num, operation)
  _G.assert((nil ~= operation), "Missing argument operation on init.fnl:260")
  _G.assert((nil ~= line_num), "Missing argument line-num on init.fnl:260")
  _G.assert((nil ~= lines), "Missing argument lines on init.fnl:260")
  do end (lines)[line_num] = operation(lines[line_num])
  return nil
end
local function get_visual_selection()
  local _, line_start, column_start, _0 = unpack(vim.fn.getpos("'<"))
  local _1, line_end, column_end, _2 = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(line_start, line_end)
  local _4_
  if (#lines == 0) then
    _4_ = lines
  else
    replace_line(lines, 1, trim_start)
    do end (lines)[1] = (lines[1]):sub(column_start)
    do end (lines)[#lines] = (lines[#lines]):sub(1, column_end)
    _4_ = lines
  end
  return print(table.concat(_4_, ", "))
end
do local _ = vim.o.selection end
vimp.vnoremap({"silent"}, "<leader>e", get_visual_selection)
local function _6_()
  return print(vim.fn.mode())
end
vimp.vnoremap({"silent"}, "<leader>w", _6_)
do
  local fzf_path = "~/.fzf/plugin/fzf.vim"
  if file_readable_3f(fzf_path) then
    vim.api.nvim_command(("source " .. fzf_path))
    vim.g.fzf_layout = {up = "~90%", window = {width = 0.8, height = 0.8, yoffset = 0.5, xoffset = 0.5, highlight = "fg", border = "sharp"}}
    vimp.nnoremap("<C-p>", ":FZF<CR>")
    vimp.nnoremap("<C-[>", ":GFiles<CR>")
    vimp.nnoremap("<C-b>", ":Buffers<CR>")
    vimp.nnoremap("<leader>gg", ":Rg<CR>")
  else
  end
end
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_view_method = "zathura"
vim.api.nvim_set_var("limelight_conceal_ctermfg", 240)
vim.call("camelcasemotion#CreateMotionMappings", ",")
vimp.omap(",iw", "<Plug>CamelCaseMotion_iw")
vimp.xmap(",iw", "<Plug>CamelCaseMotion_iw")
vimp.omap(",ib", "<Plug>CamelCaseMotion_ib")
vimp.xmap(",ib", "<Plug>CamelCaseMotion_ib")
vimp.omap(",ie", "<Plug>CamelCaseMotion_ie")
vimp.xmap(",ie", "<Plug>CamelCaseMotion_ie")
vimp.nnoremap("<leader>u", ":UndotreeToggle<CR>:wincmd h<CR>")
vim.g.delimitMate_expand_cr = 1
vimp.nnoremap("<leader>nn", ":NERDTreeToggle<CR>")
vimp.nnoremap("<leader>nf", ":NERDTreeFind<CR>")
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeMarkBookmarks = 0
vim.g.NERDTreeMapHelp = ""
vim.api.nvim_exec("autocmd FileType nerdtree setlocal relativenumber", false)
vimp.nnoremap("<leader>nc", ":Calendar")
vim.o.completeopt = "menu,menuone,noinsert,noselect"
vim.o.shortmess = (vim.o.shortmess .. "IaT")
vim.g.vimwiki_list = {{path = "~/vimwiki/", syntax = "markdown", ext = ".md", auto_diary_index = 1, auto_tags = 1}}
vim.g.vimwiki_global_ext = 0
vim.call("vimwiki#vars#init")
vim.g.taskwiki_disable_concealcursor = "yes"
vim.fn.sign_define("LspDiagnosticsErrorSign", {text = "\226\156\151", texthl = "LspDiagnosticsError", linehl = "", numhl = ""})
vim.fn.sign_define("LspDiagnosticsWarningSign", {text = "\226\128\188", texthl = "LspDiagnosticsWarning", linehl = "", numhl = ""})
vim.fn.sign_define("LspDiagnosticsInformationSign", {text = "I", texthl = "LspDiagnosticsInformation", linehl = "", numhl = ""})
vim.fn.sign_define("LspDiagnosticsHintSign", {text = "H", texthl = "LspDiagnosticsHint", linehl = "", numhl = ""})
vimp.nnoremap("K", vim.lsp.buf.hover)
vimp.nnoremap("gr", vim.lsp.buf.references)
vimp.nnoremap("g0", vim.lsp.buf.document_symbol)
vimp.nnoremap("gW", vim.lsp.buf.workspace_symbol)
vimp.nnoremap("gd", vim.lsp.buf.definition)
vimp.nnoremap({"override"}, "[e", vim.diagnostic.goto_prev)
vimp.nnoremap({"override"}, "]e", vim.diagnostic.goto_next)
vimp.nnoremap("<leader>f", vim.lsp.buf.formatting)
do
  local configs = require("nvim-treesitter.configs")
  configs.setup({ensure_installed = "maintained", sync_install = "false", ignore_install = {"norg"}, highlight = {enable = true}, refactor = {navigation = {enable = true}}, additional_vim_regex_highlighting = false})
end
do
  local lspconfig = require("lspconfig")
  lspconfig.ccls.setup({})
  lspconfig.pylsp.setup({settings = {pylsp = {plugins = {pycodestyle = {maxLineLength = 120}, flake8 = {ignore = {"F405"}, maxLineLength = 120}}}}})
  lspconfig.elixirls.setup({cmd = {"/home/addison/.local/bin/elixir-ls/release/language_server.sh"}})
  lspconfig.tsserver.setup({})
  lspconfig.vimls.setup({})
  lspconfig.rnix.setup({})
  lspconfig.bashls.setup({})
  lspconfig.texlab.setup({})
  lspconfig.ccls.setup({})
  lspconfig.julials.setup({})
  lspconfig.rust_analyzer.setup({})
end
vim.api.nvim_exec("autocmd BufWritePre *.ex,*.exs lua vim.lsp.buf.formatting_sync(nil, 1000)", false)
do
  local scratch = require("scratch")
  vimp.nnoremap({"override", "silent"}, "gss", scratch["open-last-scratchpad"])
  vimp.nnoremap({"override", "silent"}, "gs.", scratch["open-current-scratchpad"])
  vimp.nnoremap({"override", "silent"}, "gse", scratch["open-scratchpad"])
end
vimp.xmap("ga", "<Plug>(EasyAlign)")
vimp.nmap("ga", "<Plug>(EasyAlign)")
do
  local cmp = require("cmp")
  local cmp_types = require("cmp.types")
  cmp.setup({mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}), ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}), ["<C-e>"] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()})}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "path"}, {name = "buffer", keyword_length = 5}}), experimental = {ghost_text = true}, preselect = cmp.PreselectMode.None})
  cmp.setup.cmdline("/", {sources = {name = "buffer"}})
end
do
  local gitsigns = require("gitsigns")
  gitsigns.setup({numhl = true, current_line_blame = false, current_line_blame_opts = {delay = 0}})
end
return nil
