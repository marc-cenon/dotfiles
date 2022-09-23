local status, harpoon = pcall(require, "harpoon")
if (not status) then return end

local status, telescope = pcall(require, "telescope")
if (not status) then return end

telescope.load_extension('harpoon')

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
map('', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>')
map('', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('', '<leader>hn', ':lua require("harpoon.ui").nav_next() <CR>')
map('', '<leader>hp', ':lua require("harpoon.ui").nav_prev() <CR>')
map('', '<leader>ht', ':lua require("harpoon.tmux").gotoTerminal(1)<CR>')

