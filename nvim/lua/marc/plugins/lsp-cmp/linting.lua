return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      ansible = { "ansible_lint" },
      json = { "jsonlint" },
      shell = { "shellcheck" },
      lua = { "luacheck" },
      yaml = { "yamllint" },
      python = { "pylint" },
      terraform = { "tflint" },
    }
    -- remove check for global variable vim
    local luacheck = require('lint').linters.luacheck
    luacheck.args = {
      '--globals vim'
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
