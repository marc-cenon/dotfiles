-- function to create remap
function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

----------------------------------
-- show paster buffers => " <= ---
----------------------------------

-- leader key - space key
vim.g.mapleader = " "

-- nvim-tree
Map("n", "<leader>t", ":NvimTreeToggle <CR>")
Map("n", "<leader>tf", ":NvimTreeFindFileToggle <CR>")

-- open this page in buffer
Map("n", "<leader>h", ":e $HOME/.config/nvim/lua/marc/core/keymaps.lua <CR>")

-- movement
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

-- terminal
Map("t", "<C-h>", "<cmd>wincmd h<CR>")
Map("t", "<C-j>", "<cmd>wincmd j<CR>")
Map("t", "<C-k>", "<cmd>wincmd k<CR>")
Map("t", "<C-l>", "<cmd>wincmd l<CR>")

-- move block up and down in visual mode
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")

-- indent and move block in visual
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- center view when going up and down
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")

-- center the view on next match of search
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- yank to buffer
Map({ "n", "v" }, "<leader>y", [["+y]])
Map("n", "<leader>Y", [["+Y]])

--  delete to buffer
--Map({ "n", "v" }, "<leader>d", [["_d]])

-- paste in visual mode
Map("x", "<leader>p", [["_dP]])

-- close when in visual mode and save change
Map("i", "<C-c>", "<Esc>")

-- Ctrl+h to stop searching
Map('v', '<C-h>', '<cmd>nohlsearch<cr>')
Map('n', '<C-h>', '<cmd>nohlsearch<cr>')

-- replace active word
Map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- buffers
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")
Map("n", "<leader>d", ":bp|sp|bn|bd<CR>") -- delete buffer without messing windows

-- harpoon - tmux
Map("n", "<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
Map("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>')
Map("n", "<C-n>", ':lua require("harpoon.ui").nav_next() <CR>')
Map("n", "<C-p>", ':lua require("harpoon.ui").nav_prev() <CR>')
Map("n", "<leader>&", ':lua require("harpoon.ui").nav_file(1) <CR>')
Map("n", "<leader>é", ':lua require("harpoon.ui").nav_file(2) <CR>')
Map("n", '<leader>"', ':lua require("harpoon.ui").nav_file(3) <CR>')
Map("n", "<leader>'", ':lua require("harpoon.ui").nav_file(4) <CR>')
Map("n", "<leader>(", ':lua require("harpoon.ui").nav_file(5) <CR>')
Map("n", "<leader>-", ':lua require("harpoon.ui").nav_file(6) <CR>')
Map("n", "<leader>è", ':lua require("harpoon.ui").nav_file(7) <CR>')
Map("n", "<leader>_", ':lua require("harpoon.ui").nav_file(8) <CR>')
-- Map("n", "<leader>ht", ':lua require("harpoon.tmux").gotoTerminal(1)<CR>')
-- Map("n", "<leader>tt", ":silent !tmux split-window -dh <CR>")

-- telescope plugin
Map("n", "<leader>ff", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
Map("n", "<leader>fe", "<cmd> Telescope file_browser hidden=true initial_mode=normal <CR>")
Map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>")
Map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
Map("n", "<leader>th", "<cmd> Telescope help_tags <CR>") -- vim help
Map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
Map("n", "<leader>fh", "<cmd> Telescope harpoon marks<CR>")

-- open history with noice and telescope
Map("n", "<leader>N", ":Noice telescope<CR>")

-- lsp => toggle diagnostics is in lsp-plugin conf => leader + z
Map("n", "K", ":lua vim.lsp.buf.hover()<CR>") -- get lsp info
Map("n", "gd", ":lua vim.lsp.buf.definition()<CR>") -- go to definitio
Map("n", "dp", ":lua vim.diagnostic.goto_prev()<CR>") -- jump to previous diagnostic in buffer
Map("n", "dn", ":lua vim.diagnostic.goto_next()<CR>") -- jump to next diagnostic in buffer
Map("n", "<leader>r", ":lua vim.diagnostic.open_float()<CR>") -- show diagnostics for line

-- code actions, in visual mode will apply to selection
Map({ "n", "v" }, "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")

Map("n", "gR", "<cmd>Telescope lsp_references<CR>") -- show definition, references
Map("n", "tD", "<cmd>Telescope lsp_definitions<CR>") -- show lsp definitions
Map("n", "gi", "<cmd>Telescope lsp_implementations") -- show lsp implementations
Map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>") -- show lsp type definitions
Map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>") -- smart rename
Map("n", "<leader>td", ":Telescope diagnostics<CR>") -- show diagnostics
Map("n", "<leader>ts", ":Telescope lsp_document_symbols<CR>")
Map("n", "<leader>tS", ":Telescope lsp_workspace_symbols<CR>")
Map("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- oil filesystem
Map("n", "<leader>o", ":Oil --float<CR>")

-- undotree toogle
Map("n", "<leader>u", ":UndotreeToggle<CR>")

-- trouble
Map("n", "<leader>tt", ':lua require("trouble").toggle()<CR>')
Map("n", "<leader>tw", ':lua require("trouble").toggle("workspace_diagnostics")<CR>')
Map("n", "<leader>td", ':lua require("trouble").toggle("document_diagnostics")<CR>')
Map("n", "<leader>tq", ':lua require("trouble").toggle("quickfix")<CR>')
Map("n", "<leader>tl", ':lua require("trouble").toggle("loclist")<CR>')
Map("n", "gR", ':lua require("trouble").toggle("lsp_references")<CR>')
----------------------------
----------------------------
-- old mappings

-- git diff to resolve conflit with fugitive (dv)
-- Map("n", "gh", "<cmd>diffget //2<CR>")
-- Map("n", "gh", "<cmd>diffget //3<CR>")
-- Map("n", "<leader>gg", ":Git<CR>")

--Map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
--Map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>") -- show  diagnostics for file
-- netrw (disabled)
-- Map("n", "<leader>m", vim.cmd.Vex)

-- ~/.config/nvim/lua/plugins/init.lua

-- Set up commands
-- Set up key mappings (e.g., <Leader>sd for Leader + sd, <Leader>se for Leader + se)
