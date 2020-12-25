local function file_readable_3f(path)
  assert((nil ~= path), string.format("Missing argument %s on %s:%s", "path", "init.fnl", 1))
  return (1 == vim.fn.filereadable(vim.fn.expand(path)))
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
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "nosplit"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.breakindent = true
vim.cmd("set foldlevel=99")
vim.cmd("set noshowcmd")
vim.cmd("set noshowmode")
vim.o.hidden = true
vim.o.sidescroll = 1
vim.o.lazyredraw = true
vim.cmd("set signcolumn=yes")
vim.cmd("set nowrap")
vim.o.wildmenu = true
vim.cmd("set list")
vim.o.undofile = true
vim.o.undodir = "$HOME/.config/nvim/undo"
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.listchars = "tab:  ,nbsp:\226\144\163,extends:>,precedes:<,eol: ,trail:\194\183"
vim.g.currentmode = {R = "REPLACE", Rv = "V\194\183REPLACE", S = "S\194\183LINE", V = "V\194\183LINE", ["!"] = "SHELL", ["\19"] = "S\194\183BLOCK", ["\22"] = "V\194\183BLOCK", ["r?"] = "CONFIRM", c = "COMMAND", ce = "EX", cv = "VIM EX", i = "INSERT", n = "NORMAL", no = "N\194\183OPERATOR PENDING", r = "PROMPT", rm = "MORE", s = "SELECT", t = "TERMINAL", v = "VISUAL"}
vim.api.nvim_exec("\nfunction! Filetype()\n\9if &filetype == ''\n\9\9return ''\n\9else\n\9\9return '[' . &filetype . '] '\n\9endif\nendfunction\n", false)
vim.cmd("set noruler")
vim.o.laststatus = 2
vim.o.statusline = ("[%{g:currentmode[mode()]}]" .. " %.40t" .. "%=" .. "%m " .. "%{Filetype()}" .. "[%3l/%L] " .. "[%3p%%] ")
vim.o.mouse = "a"
vim.o.splitright = true
vim.g.previewheight = vim.fn.floor((vim.fn.winwidth(0) / 2))
vimp.nnoremap("<leader>l", ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>h ")
vimp.cnoremap("w!!", "w suda://%")
vimp.nnoremap(":", ";")
vimp.nnoremap(";", ":")
vimp.vnoremap(":", ";")
vimp.vnoremap(";", ":")
vimp.inoremap("jk", "<ESC>")
vimp.cnoremap("jk", "<ESC>")
vimp.vnoremap("jk", "<ESC>")
vimp.nnoremap("<leader>j", "gt")
vimp.nnoremap("<leader>k", "gT")
vimp.nnoremap("<leader>y", "\"+y")
vimp.nnoremap("<leader>Y", "\"+y$")
vimp.nnoremap("<leader>p", "\"+p")
vimp.nnoremap("<leader>P", "\"+P")
vimp.vnoremap("<leader>y", "\"+y")
vimp.vnoremap("<leader>Y", "\"+y$")
vimp.nnoremap("Y", "y$")
vimp.nnoremap("yoe", ":set linebreak!<CR>")
local function _0_()
  local command = nil
  do
    local filetype = vim.api.nvim_eval("&filetype")
    local filename = vim.fn.expand("%")
    local filename_no_ext = vim.fn.expand("%<")
    if (filetype == "c") then
      command = ("gcc -o " .. filename_no_ext .. " " .. filename .. " && ./" .. filename_no_ext)
    elseif (filetype == "perl") then
      command = ("python3 " .. filename)
    elseif (filetype == "java") then
      command = ("java " .. filename_no_ext)
    elseif (filetype == "sh") then
      command = ("./ " .. filename)
    elseif (filetype == "python") then
      command = ("python3 " .. filename)
    elseif (filetype == "html") then
      command = ("!google-chrome-beta " .. filename .. " &")
    elseif (filetype == "go") then
      command = ":GoRun"
    elseif (filetype == "haskell") then
      command = ("runhaskell " .. filename)
    elseif (filetype == "tex") then
      command = ("zathura " .. filename_no_ext .. ".pdf")
    elseif (filetype == "elixir") then
      command = ("elixir " .. filename)
    elseif (filetype == "r") then
      command = ("Rscript " .. filename)
    elseif (filetype == "lua") then
      command = ("lua " .. filename)
    else
      command = nil
    end
  end
  if command then
    return vim.cmd(("!tmux split-window -v -p 20 '" .. command .. " |& nvim -u ~/.config/nvim/ftplugin/more.vim -'"))
  else
    return print("not supported yet!")
  end
end
vimp.nnoremap({"silent"}, "<leader>r", _0_)
local function _1_()
  local command = nil
  do
    local filetype = vim.api.nvim_eval("&filetype")
    local filename = vim.fn.expand("%")
    local filename_no_ext = vim.fn.expand("%<")
    if (filetype == "python") then
      command = ("python3 -i " .. filename)
    elseif (filetype == "elixir") then
      command = ("iex " .. filename)
    elseif (filetype == "r") then
      command = "R --no-save"
    elseif (filetype == "scheme") then
      command = ("python3 scheme -i " .. filename)
    elseif (filetype == "lua") then
      command = ("lua -i " .. filename)
    else
      command = nil
    end
  end
  if command then
    return vim.cmd(("!tmux split-window -v -p 20 " .. command))
  else
    return print("not supported yet!")
  end
end
vimp.nnoremap({"silent"}, "<leader>i", _1_)
do
  local fzf_path = "~/.fzf/plugin/fzf.vim"
  if file_readable_3f(fzf_path) then
    vim.api.nvim_command(("source " .. fzf_path))
    vim.g.fzf_layout = {up = "~90%", window = {border = "sharp", height = 0.80000000000000004, highlight = "fg", width = 0.80000000000000004, xoffset = 0.5, yoffset = 0.5}}
    vimp.nnoremap("<C-p>", ":FZF<CR>")
    vimp.nnoremap("<C-b>", ":Buffers<CR>")
    vimp.nnoremap("<leader>gg", ":Rg<CR>")
  end
end
vimp.nnoremap("<leader>va", ":VtrAttachToPane<CR>")
vimp.nnoremap("<leader>vs", ":VtrSendLinesToRunner<CR>")
vimp.vnoremap("<leader>vs", ":VtrSendLinesToRunner<CR>")
vim.g.VtrStripLeadingWhitespace = 0
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
vim.api.nvim_exec("autocmd FileType nerdtree setlocal relativenumber", false)
vimp.nnoremap("<leader>nc", ":Calendar")
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = (vim.o.shortmess .. "IaT")
vim.g.vimwiki_list = {{auto_diary_index = 1, auto_tags = 1, ext = ".md", path = "~/vimwiki/", syntax = "markdown"}}
vim.g.vimwiki_global_ext = 0
vim.call("vimwiki#vars#init")
vim.fn.sign_define("LspDiagnosticsErrorSign", {linehl = "", numhl = "", text = "\226\156\151", texthl = "LspDiagnosticsError"})
vim.fn.sign_define("LspDiagnosticsWarningSign", {linehl = "", numhl = "", text = "\226\128\188", texthl = "LspDiagnosticsWarning"})
vim.fn.sign_define("LspDiagnosticsInformationSign", {linehl = "", numhl = "", text = "I", texthl = "LspDiagnosticsInformation"})
vim.fn.sign_define("LspDiagnosticsHintSign", {linehl = "", numhl = "", text = "H", texthl = "LspDiagnosticsHint"})
vimp.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vimp.nnoremap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vimp.nnoremap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vimp.nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vimp.nnoremap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
vimp.nnoremap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
vimp.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
do
  local configs = require("nvim-treesitter.configs")
  configs.setup({ensure_installed = "all", highlight = {enable = true}, refactor = {navigation = {enable = true}}})
end
do
  local lspconfig = require("lspconfig")
  lspconfig.ccls.setup({})
  lspconfig.pyls.setup({settings = {pyls = {plugins = {pycodestyle = {enabled = false}}}}})
  lspconfig.elixirls.setup({cmd = "/home/addison/.local/bin/elixir-ls/release/language_server.sh", settings = {elixirLS = {dialyzerEnabled = false}}})
  lspconfig.tsserver.setup({})
  lspconfig.vimls.setup({})
  lspconfig.rnix.setup({})
  lspconfig.bashls.setup({})
  lspconfig.texlab.setup({})
end
return nil
