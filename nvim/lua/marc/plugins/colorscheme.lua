return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")

		catppuccin.setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			integrations = {
				alpha = true,
				harpoon = true,
				mason = true,
				native_lsp = { enabled = true },
				neotree = true,
				symbols_outline = true,
				telescope = true,
				treesitter_context = true,
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
