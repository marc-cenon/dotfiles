local status, telescope = pcall(require, "telescope")

if (not status) then return end

telescope.load_extension("file_browser")
telescope.load_extension('dap')
telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = 'top',
    },
  },
}

-- load extensions
require("telescope").load_extension('file_browser')
require("telescope").load_extension('emoji')
require("telescope").load_extension('harpoon')
