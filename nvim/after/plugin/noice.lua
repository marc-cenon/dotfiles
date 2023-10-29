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
    }
  }
}
