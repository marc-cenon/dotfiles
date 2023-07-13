local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

local mocha = require("catppuccin.palettes").get_palette "mocha"

bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "bold" },
        custom = {
            all = {
                fill = { bg = "#1e1e2e" }, --base color
            },
            mocha = {
                background = { fg = mocha.text },
            },
        },
    },
}
