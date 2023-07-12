local status, telescope = pcall(require, "telescope")
local status2, actions = pcall(require, "telescope.actions")

if (not status and status2) then return end

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
        ["<esc>"] = actions.close,
        ["<C-a>"] = actions.toggle_selection,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        -- doesn't work for some reason
        -- ["<Down>"] = actions.toggle_selection + actions.move_selection_worse,
        -- ["<Up>"] = actions.toggle_selection + actions.move_selection_better,
      },
    },
  },
}

-- load extensions
require("telescope").load_extension "file_browser"
require("telescope").load_extension "emoji"
