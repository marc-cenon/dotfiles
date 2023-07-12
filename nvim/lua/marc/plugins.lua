local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "folke/neodev.nvim",                      opts = {} },
  -- dap
  { "mfussenegger/nvim-dap" },
  { "nvim-telescope/telescope-dap.nvim" },
  -- multiple visual cursor
  { 'mg979/vim-visual-multi',                 branch = 'master' },
  -- { "numToStr/Comment.nvim",                  opts = {} },
  -- which-key 
  { "folke/which-key.nvim",                   opts = {} },
  -- overide default vim.ui
  { "stevearc/dressing.nvim",                 event = "VeryLazy", opts = {} },
  -- telescope
  { "xiyaowong/telescope-emoji.nvim" },
  { "nvim-telescope/telescope.nvim",        tag = "0.1.1",
  dependencies = {
    "nvim-lua/plenary.nvim"
    },
  },
  { "nvim-telescope/telescope-file-browser.nvim" },
  -- treesiter
  { 'nvim-treesitter/nvim-treesitter-context' },
  { "nvim-treesitter/nvim-treesitter",
  -- helm config for treesiter
  { 'towolf/vim-helm' },
  -- git blame
  { "APZelos/blamer.nvim" },
  -- structural search and replace
  { "cshuaimin/ssr.nvim" },
  -- zen mode
  { "folke/zen-mode.nvim" },
  -- smoth scrollong
  { "karb94/neoscroll.nvim" },
  -- notification
  { "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  -- auto pairing
  { 'echasnovski/mini.pairs',               version = false },
  -- bufferline
  { 'akinsho/bufferline.nvim',              version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },
  -- comment plugin
  { "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  -- lsp - mason - cmp 
  { "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim",          config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim",                tag= 'legacy' },
      { "folke/neodev.nvim" },
    },
  },
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer"
    },
  },
  -- gitsigns
  { "lewis6991/gitsigns.nvim" },
  -- lualine
  { "nvim-lualine/lualine.nvim" },
  -- blankline
  { "lukas-reineke/indent-blankline.nvim" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
-- theme  
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

-- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})
	-- {	
	--{ 'folke/tokyonight.nvim' },
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			api_key_cmd = "cat ~/.openai_key"
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim"
	-- 	}
	-- },
