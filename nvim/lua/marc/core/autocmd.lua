local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- Taken from: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- leave paste mode when leaving insert mode (if it was on)
autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
