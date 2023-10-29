local status, telescope = pcall(require, "telescope")
local status2, actions = pcall(require, "telescope.actions")

if (not status and status2) then return end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.load_extension("file_browser")
telescope.load_extension('dap')
telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ["<C-w>"] = function() vim.cmd('normal vbd') end,
        ["<esc>"] = actions.close,
        ["<C-a>"] = actions.toggle_selection,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
    },
  },
}

-- load extensions
require("telescope").load_extension "file_browser"
require("telescope").load_extension "emoji"
require("telescope").load_extension('harpoon')

