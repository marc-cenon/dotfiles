return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter.configs")

      ---@diagnostic disable-next-line: missing-fields
      treesitter.setup({
        ensure_installed = {
          "python",
          "lua",
          "bash",
          "regex",
          "markdown",
          "markdown_inline",
          "dockerfile",
          "go",
          "hcl",
          "json",
          "sql",
          "yaml",
          "toml",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        indent = {
          enable = false,
        },
      })
    end,
  },
}
