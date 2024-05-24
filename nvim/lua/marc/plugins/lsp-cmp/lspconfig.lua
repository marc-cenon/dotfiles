return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugins and cmp_nvim_lsp plugin
    local configs = require("lspconfig.configs")
    local util = require("lspconfig.util")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- function to toggle lsp diagnostics
    local diagnostics_active = true
    local toggle_diagnostics = function()
      diagnostics_active = not diagnostics_active
      if diagnostics_active then
        vim.diagnostic.show()
      else
        vim.diagnostic.hide()
      end
    end
    vim.keymap.set("n", "<leader>z", toggle_diagnostics)

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- disable diagnostic virtual text
    vim.diagnostic.config({
      virtual_text = false,
      underline = false,
    })

    -- server list for lsp
    local servers = {
      "ansiblels",
      "dockerls",
      "bashls",
      "pyright",
      "jsonls",
      "sqlls",
      "yamlls",
    }

    -- attach the servers table to lsp
    for _, lsp in pairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        },
      })
    end

    -- helm lsp conf
    if not configs.helm_ls then
      configs.helm_ls = {
        default_config = {
          cmd = { "helm_ls", "serve" },
          filetypes = { "helm" },
          root_dir = function(fname)
            return util.root_pattern("Chart.yaml")(fname)
          end,
        },
      }
    end

    -- terraform lsp conf
    lspconfig.terraformls.setup({
      capabilities = capabilities,
      filetypes = { "tf", "tfvar", "terraform" },
    })

    -- yaml lsp conf
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemas = {
            kubernetes = "*.yaml",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
          },
        },
      },
    })

    -- lua lsp conf
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
