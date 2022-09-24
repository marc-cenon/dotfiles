require'nvim-treesitter.configs'.setup {
  ensure_installed = { 
    "python", 
    "lua", 
    "bash", 
    "dockerfile", 
    "go", 
    "hcl", 
    "json", 
    "sql", 
    "yaml", 
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
