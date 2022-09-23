local status, catpuccin = pcall(require, "catppuccin")
if (not status) then return end

local status2, tokyo = pcall(require, "tokyo")
if (not status) then return end


--vim.g.catppuccin_flavour = "mocha"

local status, lualine = pcall(require, "lualine")
if (not status) then return end

--vim.cmd [[colorscheme catppuccin]]
--[[lualine.setup {
  options = {
    theme = "catppuccin",
    component_separators = '|',
    section_separators = '',
  }
}
--]]

vim.cmd [[colorscheme tokyonight-night]]
lualine.setup {
  options = {
    theme = "tokyonight",
    style = "night",
    component_separators = '|',
    section_separators = '',
  }
}
