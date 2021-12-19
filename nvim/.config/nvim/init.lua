__fnl_global__UNNAMED_2dREGISTER = "\""
local function file_readable_3f(path)
  _G.assert((nil ~= path), "Missing argument path on init.fnl:3")
  return (1 == vim.fn.filereadable(vim.fn.expand(path)))
end
local function open_split(command)
  _G.assert((nil ~= command), "Missing argument command on init.fnl:7")
  local bufheight = vim.fn.floor((vim.fn.winheight(0) / 5))
  return vim.cmd(("belowright " .. bufheight .. "split term://" .. command))
end
vim.g.polyglot_disabled = {"markdown"}
vim.cmd("packadd vim-polyglot")
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
vim.cmd("set foldlevel=99")
vim.o.showcmd = false
vim.o.showmode = false
vim.o.hidden = true
vim.o.sidescroll = 1
vim.o.lazyredraw = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false
vim.o.wildmenu = true
vim.wo.list = true
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.listchars = "tab:  ,nbsp:\226\144\163,extends:>,precedes:<,eol: ,trail:\194\183"
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
vim.o.laststatus = 2
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
local function _2_()
  local command
  do
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
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
    elseif (filetype == "julia") then
      command = ("julia " .. filename)
    else
      command = nil
    end
  end
  if command then
    return open_split(command)
  else
    return print("not supported yet!")
  end
end
vimp.nnoremap({"silent"}, "<leader>r", _2_)
local function _5_()
  local command
  do
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    local filename = vim.fn.expand("%")
    local filename_no_ext = vim.fn.expand("%<")
    if (filetype == "python") then
      command = ("python3 -i " .. filename)
    elseif (filetype == "elixir") then
      command = "iex"
    elseif (filetype == "r") then
      command = "R --no-save"
    elseif (filetype == "scheme") then
      command = ("python3 scheme -i " .. filename)
    elseif (filetype == "lua") then
      command = ("lua -i " .. filename)
    elseif (filetype == "julia") then
      command = ("julia -i " .. filename)
    else
      command = "zsh"
    end
  end
  if command then
    return open_split(command)
  else
    return print("not supported yet!")
  end
end
vimp.nnoremap({"silent"}, "<leader>i", _5_)
do
  local letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
  for _, letter in ipairs(letters) do
    local function _8_()
      local command = string.gsub(string.match(vim.fn.getreg(letter), "^%s*(.-)%s*$"), "\"", "\\\"")
      local bufheight = vim.fn.floor((vim.fn.winheight(0) / 5))
      if (command == "") then
        return print(("nothing bound to register '" .. letter .. "' !"))
      else
        return open_split(command)
      end
    end
    vimp.nnoremap({"silent"}, ("!" .. letter), _8_)
  end
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
  local _10_
  if (#lines == 0) then
    _10_ = lines
  else
    replace_line(lines, 1, trim_start)
    do end (lines)[1] = (lines[1]):sub(column_start)
    do end (lines)[#lines] = (lines[#lines]):sub(1, column_end)
    _10_ = lines
  end
  return print(table.concat(_10_, ", "))
end
do local _ = vim.o.selection end
vimp.vnoremap({"silent"}, "<leader>e", get_visual_selection)
local function _12_()
  return print(vim.fn.mode())
end
vimp.vnoremap({"silent"}, "<leader>w", _12_)
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
vim.api.nvim_exec("autocmd FileType nerdtree setlocal relativenumber", false)
vimp.nnoremap("<leader>nc", ":Calendar")
vim.o.completeopt = "menuone,noinsert,noselect"
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
vimp.nnoremap({"override"}, "[e", vim.lsp.diagnostic.goto_prev)
vimp.nnoremap({"override"}, "]e", vim.lsp.diagnostic.goto_next)
do
  local configs = require("nvim-treesitter.configs")
  configs.setup({ensure_installed = "all", highlight = {enable = true}, refactor = {navigation = {enable = true}}})
end
do
  local lspconfig = require("lspconfig")
  lspconfig.ccls.setup({})
  lspconfig.pylsp.setup({settings = {pylsp = {plugins = {pycodestyle = {enabled = false}, pyflakes = {enabled = false}}}}})
  lspconfig.elixirls.setup({cmd = {"/home/addison/.local/bin/elixir-ls/release/language_server.sh"}})
  lspconfig.tsserver.setup({})
  lspconfig.vimls.setup({})
  lspconfig.rnix.setup({})
  lspconfig.bashls.setup({})
  lspconfig.texlab.setup({})
  lspconfig.ccls.setup({})
  lspconfig.julials.setup({})
  lspconfig.rls.setup({})
end
do
  local codeAction = require("lsputil.codeAction")
  local locations = require("lsputil.locations")
  local symbols = require("lsputil.symbols")
  do end (vim.lsp.handlers)["textDocument/codeAction"] = codeAction.code_action_handler
  vim.lsp.handlers["textDocument/references"] = locations.references_handler
  vim.lsp.handlers["textDocument/definition"] = locations.definition_handler
  vim.lsp.handlers["textDocument/declaration"] = locations.declaration_handler
  vim.lsp.handlers["textDocument/typeDefinition"] = locations.typeDefinition_handler
  vim.lsp.handlers["textDocument/implementation"] = locations.implementation_handler
  vim.lsp.handlers["textDocument/documentSymbol"] = locations.document_handler
  vim.lsp.handlers["workplace/symbol"] = symbols.workspace_handler
end
vim.api.nvim_exec("autocmd BufWritePre *.ex,*.exs lua vim.lsp.buf.formatting_sync(nil, 1000)", false)
vim.g.completion_enable_snippet = "Ultisnips"
vim.api.nvim_exec("autocmd BufEnter * lua require'completion'.on_attach()", false)
vim.g.scratch_autohide = 0
vim.g.scratch_insert_autohide = 0
vim.g.scratch_filetype = "markdown"
vim.g.scratch_persistence_file = ".scratch.vim"
vimp.xmap("ga", "<Plug>(EasyAlign)")
vimp.nmap("ga", "<Plug>(EasyAlign)")
return nil
