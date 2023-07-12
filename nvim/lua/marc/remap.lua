function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- leader key
vim.g.mapleader = " "

-- menu
Map("n", "<leader>m", vim.cmd.Ex)

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
Map({"n", "v"}, "<leader>y", [["+y]])
Map("n", "<leader>Y", [["+Y]])

--  delete to buffer
Map({"n", "v"}, "<leader>d", [["_d]])

-- buffer and tabs
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")
Map("n", "<leader>bd", ":bd<CR>")

-- telescope plugin
Map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
Map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
Map("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
Map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
Map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
Map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
Map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
Map("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")
Map("n", "<leader>D", ":Telescope diagnostics<CR>")
Map("n", "<leader>ts", ":Telescope lsp_document_symbols<CR>")
Map("n", "<leader>tS", ":Telescope lsp_workspace_symbols<CR>")
Map('n', '<leader>N', ":Noice telescope<CR>")

-- lsp
Map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
Map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
Map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
Map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
Map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

--  ssr plugin
Map({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)

-- zen mode
Map('n', '<leader>zz', ":ZenMode<CR>")

-- markdown preview
Map("n", "<leader>md", ":MarkdownPreview <CR>")
