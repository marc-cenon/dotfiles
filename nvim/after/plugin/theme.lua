local status, catppuccin = pcall(require, "catppuccin")
if (not status and status2) then return end

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    }
})

vim.cmd.colorscheme "catppuccin"
