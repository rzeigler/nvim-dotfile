require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'feline-nvim/feline.nvim'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup{} end,
  }
  use {
    'folke/which-key.nvim',
    config = function() 
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup{}
    end
  }
  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup{} end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{} end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() 
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('nvim-treesitter.configs').setup{} end,
  }
  use { 
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {'nvim-treesitter/nvim-treesitter'},
  }
end)

vim.g.mapleader = ','
vim.cmd('colorscheme dayfox')
vim.cmd('set number')
vim.cmd('set expandtab shiftwidth=2 tabstop=2')



