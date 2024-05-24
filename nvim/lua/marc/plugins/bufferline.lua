return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "BufReadPre",

  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            text_align = "left",
            separator = true,
          },
        },
      },
    })
  end,
}
