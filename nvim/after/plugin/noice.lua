local status, noice = pcall(require, "noice")
if (not status) then return end

noice.setup {
  cmdline = {
    format = {
      cmdline = { icon = ">" },
      search_down = { icon = "search [v]" },
      search_up = { icon = "search [^]" },
      filter = { icon = "filter" },
      lua = { icon = "lua" },
      help = { icon = "help" },
    },
  },
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true, -- enables the Noice messages UI
    view = "notify", -- default view for messages
    view_error = "split", -- view for errors
    view_warn = "split", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
}
