function Map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
Map('', '<leader>f', ':Telescope find_files<CR>')
Map('', '<leader>g', ':Telescope live_grep<CR>')
Map('', '<leader>tb', ':Telescope buffers<CR>')
Map('', '<leader>tm', ':Telescope harpoon marks<CR>')
