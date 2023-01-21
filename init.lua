require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'

  use 'lifepillar/vim-solarized8'
  use 'ellisonleao/gruvbox.nvim'
  use 'folke/tokyonight.nvim'

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
    end
  }

  use 'RRethy/nvim-treesitter-textsubjects'

  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    'nvim-treesitter/nvim-treesitter',
    require =  { 'nvim-treesitter/nvim-treesitter-textobjects', 'RRethy/nvim-treesitter-textsubjects' },
    run = function() 
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup{
        highlight = {
          enable = true
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            }
          }
        },
        -- Doesn't support java, oh well.
        -- textsubjects = {
        --   enable = true,
        --   prev_selection = ',',
        --   keymaps = {
        --     ['.'] = 'textsubjects-smart',
        --     [';'] = 'textsubjects-container-outer',
        --     ['i;'] = 'textsubjects-container-inner'
        --   }
        -- }
      }
    end
  }

  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require("telescope").setup {}
      require("telescope").load_extension("ui-select")
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
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use { 
    'dcampos/nvim-snippy',
    config = function()
      require('snippy').setup({
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      })
    end
  }
  use 'dcampos/cmp-snippy'

  use 'onsails/lspkind.nvim'

  use 'mfussenegger/nvim-dap'


  use 'mfussenegger/nvim-jdtls'
end)


vim.g.mapleader = ','

vim.o.background='dark'
vim.cmd('colorscheme solarized8')
vim.cmd('set number')
vim.cmd('set expandtab shiftwidth=2 tabstop=2')

vim.cmd('set completeopt=menu,menuone,noselect')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>hx', '<cmd>nohl<CR>', opts)
vim.keymap.set('n', '<leader>qx', '<cmd>cclose<CR>', opts)
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>', opts);
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>', opts);

vim.keymap.set('n', '<leader>lx', '<cmd>lclose<CR>', opts)
vim.keymap.set('n', '<leader>ln', '<cmd>lnext<CR>', opts);
vim.keymap.set('n', '<leader>lp', '<cmd>lprev<CR>', opts);

vim.keymap.set('n', '<leader>nw', '<cmd>Explore<CR>', opts)
vim.keymap.set('n', '<leader>nh', '<cmd>Sexplore<CR>', opts)
vim.keymap.set('n', '<leader>nv', '<cmd>Vexplore<CR>', opts)

vim.keymap.set('n', '<leader>tc', '<cmd>tabnew', opts)
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext', opts)
vim.keymap.set('n', '<leader>tp', '<cmd>tabprev', opts)


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader>fj', builtin.jumplist, opts)

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
local lspkind = require'lspkind'

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  },
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body) -- For `snippy` users.
    end
  },
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
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'nvim_lsp_signature_help' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['tsserver'].setup { 
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

require('lspconfig')['bashls'].setup{
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

require('lspconfig')['pyright'].setup{
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

