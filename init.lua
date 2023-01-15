require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'

  use 'EdenEast/nightfox.nvim'

  use 'feline-nvim/feline.nvim'

  use {
    'lewis6991/gitsigns.nvim',
    config = function() 
        require('gitsigns').setup{}
    end,
  }

  use {
    'folke/which-key.nvim',
    config = function() 
      vim.o.timeout = true
      vim.o.timeoutlen = 400
      require('which-key').setup{}
    end
  }

  use {
    'kylechui/nvim-surround',
    tag = '*',
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() 
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup{}
    end,
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup {}
    end
  }

  use 'neovim/nvim-lspconfig'

  use 'mfussenegger/nvim-dap'

  use 'mfussenegger/nvim-jdtls'
end)

vim.g.mapleader = ','
vim.cmd('colorscheme dayfox')
vim.cmd('set number')
vim.cmd('set expandtab shiftwidth=2 tabstop=2')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>hx', ':nohl<CR>', opts)
vim.keymap.set('n', '<leader>qx', ':cclose<CR>', opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Diagnostics
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- LSP Telescope
vim.keymap.set('n', '<space>fr', builtin.lsp_references, opts)
vim.keymap.set('n', '<space>s', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', '<space>d', builtin.diagnostics, opts)


require('lspconfig')['tsserver'].setup { 
  on_attach = require('my_lsp').on_attach
}

