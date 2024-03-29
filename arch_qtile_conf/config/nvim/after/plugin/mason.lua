local status, mason = pcall(require, "mason")
if (not status) then return end

local status, lspconfig = pcall(require, "mason-lspconfig")
if (not status) then return end


mason.setup({

})

lspconfig.setup ({
  ensure_installed = {
    "sumneko_lua",
    "yamlls",
    "rust_analyzer",
    "bashls",
    "dockerls",
    "gopls",
    "jsonls",
    "pyright",
    "sqls",
    "taplo",
    "terraformls",
  },
  automatic_installation = true,
})
