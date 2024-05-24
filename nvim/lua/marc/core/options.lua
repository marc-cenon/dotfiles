-- global neovim conf

--  share clipboard
vim.api.nvim_set_option("clipboard","unnamed")

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
-- custom conf

local opt = vim.opt
opt.signcolumn = "yes"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.guicursor = ""
opt.termguicolors = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.listchars = { tab = '│ ', eol = '↩', trail = '•', precedes = '←', extends = '→' }
opt.mouse = "a"
opt.mousemev = true
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
opt.completeopt = 'menuone,noselect'

