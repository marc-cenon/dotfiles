function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
map('', '<leader>f', ':Telescope find_files<CR>')
map('', '<leader>g', ':Telescope live_grep<CR>')
map('', '<leader>tb', ':Telescope buffers<CR>')
map('', '<leader>tm', ':Telescope harpoon marks<CR>')
