return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local noice = require("noice")
    local notify = require("notify")

    -- timeout and style of the windows notifications
    notify.setup({
      minimum_width = 60,
      render = "wrapped-compact",
      stages = "fade",
      timeout = 1000,
      top_down = true,
      background_colour = "#000000" -- notification transparent background
    })

    noice.setup({
      views = {
        mini = {
          border = {
            style = "none",
          },
          win_options = {
            winblend = 0,
            },
          }
      },
      presets = {
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true,    -- add a border to hover docs and signature help↩
        bottom_search = true,
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = { icon = ">" },
          search_down = { icon = "search [v]" },
          search_up = { icon = "search [^]" },
          filter = { icon = "filter" },
          lua = { icon = "lua" },
          help = { icon = "help" },
        },
      },
    })
  end,
}
