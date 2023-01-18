require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'

  use 'EdenEast/nightfox.nvim'
  use 'sainnhe/edge'


  use 'feline-nvim/feline.nvim'

  use 'tpope/vim-eunuch'
  use 'tpope/vim-vinegar'

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
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {
      }
    end,
  }

  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
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
      require('nvim-treesitter.configs').setup{
        highlight = {
          enable = true
        }
      }
    end,
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup {}
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function() 
      require('fidget').setup{}
    end
  }

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'mfussenegger/nvim-dap'

  use 'mfussenegger/nvim-jdtls'
end)




vim.g.mapleader = ','

vim.cmd('colorscheme edge')
vim.cmd('set number')
vim.cmd('set expandtab shiftwidth=2 tabstop=2')

vim.cmd('set completeopt=menu,menuone')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>hx', ':nohl<CR>', opts)
vim.keymap.set('n', '<leader>qx', ':cclose<CR>', opts)
vim.keymap.set('n', '<leader>nw', '<cmd>:Explore<CR>', opts)
vim.keymap.set('n', '<leader>nh', '<cmd>:Sexplore<CR>', opts)
vim.keymap.set('n', '<leader>nv', '<cmd>:Vexplore<CR>', opts)

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
vim.keymap.set('n', '<space>sd', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', '<space>sw', builtin.lsp_dynamic_workspace_symbols, opts)
vim.keymap.set('n', '<space>d', builtin.diagnostics, opts)


local cmp = require'cmp'

cmp.setup({

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })},
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['tsserver'].setup { 
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

