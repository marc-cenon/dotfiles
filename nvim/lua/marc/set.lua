
--------------------------- global nvm conf
vim.api.nvim_set_option("clipboard","unnamed")

vim.g.netrw_winsize = 30

local opt = vim.opt

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.guicursor = ""
opt.termguicolors = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.listchars = { tab = '│ ', eol = '↩', trail = '•', space = '⋅', precedes = '←', extends = '→' }
opt.mouse = "a"
opt.wrap = true
opt.colorcolumn = "80"
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.laststatus = 2
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
opt.splitbelow = true
opt.splitright = true
opt.list = true
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.showcmd = true
opt.cmdheight = 1
opt.autoindent = true
opt.smartindent = true

