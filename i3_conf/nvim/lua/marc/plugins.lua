-- Bootstrat packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
vim.cmd [[packadd packer.nvim]]

-- Plugins selection
return require('packer').startup(function(use)
  use("wbthomason/packer.nvim")
  use("sbdchd/neoformat")
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use("ThePrimeagen/harpoon")
  use 'nvim-treesitter/nvim-treesitter'
  use {"folke/tokyonight.nvim", as = "tokyo" }
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
	use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
	use 'williamboman/nvim-lsp-installer'
	use 'hashivim/vim-terraform'
  use 'simrat39/rust-tools.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
