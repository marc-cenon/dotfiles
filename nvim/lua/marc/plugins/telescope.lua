return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"xiyaowong/telescope-emoji.nvim",
		-- telescope extension for file browser
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
				},
				mappings = {
					i = {
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
						["<esc>"] = actions.close,
						["<C-a>"] = actions.toggle_selection,
						["<Tab>"] = actions.move_selection_next,
						["<S-Tab>"] = actions.move_selection_previous,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
			pickers = {
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
		})
		-- load extensions
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("emoji")
		require("telescope").load_extension("harpoon")
		require("telescope").load_extension("fzf")
	end,
}
