return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "helm_ls",
        "yamlls",
        "bashls",
        "dockerls",
        "gopls",
        "jsonls",
        "pyright",
        "ansiblels",
        "terraformls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
    -- linters to install for nvim-lint
    mason_tool_installer.setup({
      ensure_installed = {
        "pylint",   -- python linter
        "ansible-lint", -- ansible linter
        "jsonlint", -- json linter
        "pylint",   -- python linter
        "selene",   -- lua linter
        "isort",    -- python lib /utility for imports
        "yamllint", -- yaml linter
        "tflint",   -- terraform linter
      },
    })
  end,
}
