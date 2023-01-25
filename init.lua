require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'sainnhe/sonokai'

  use 'godlygeek/tabular'

  use 'ixru/nvim-markdown'
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use 'arkav/lualine-lsp-progress'
  use 'kyazdani42/nvim-web-devicons' 

  use {
    'nvim-lualine/lualine.nvim',
    requires = {{ 'kyazdani42/nvim-web-devicons' },
                { 'arkav/lualine-lsp-progress' },
                { 'sainnhe/sonokai' } },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'sonokai'
        },
        sections = {
          lualine_c = {
            'filename',
            'lsp_progress'
          }
        }
      })
    end
  }

  use 'tpope/vim-eunuch'
  use 'tpope/vim-vinegar'

  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('vgit').setup()
    end
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
  use 'nvim-telescope/telescope-dap.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = "0.1.0",
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      local telescope = require('telescope')
      telescope.setup {}
      telescope.load_extension('ui-select')
      telescope.load_extension('dap')
    end
  }
  

  use 'neovim/nvim-lspconfig'

  use 'jubnzv/virtual-types.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'rcarriga/cmp-dap'
  use 'dcampos/cmp-snippy'
  use 'onsails/lspkind.nvim'
  use {
    'hrsh7th/nvim-cmp',
    require = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'rcarriga/cmp-dap',
      'onsails/lspkind.nvim'
    },
    config = function()
      local cmp = require'cmp'
      local lspkind = require'lspkind'
      cmp.setup({
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
          or require("cmp_dap").is_dap_buffer()
        end,
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

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

    end
  }

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

  use 'mfussenegger/nvim-dap'

  use {
    'simrat39/rust-tools.nvim',
    config = function()
      local my_lsp = require('my_lsp')
      require('rust-tools').setup({
        server = {
          on_attach = my_lsp.on_attach
        }
      })
    end
  }

  use 'mfussenegger/nvim-jdtls'
end)


vim.g.mapleader = ','
vim.g.sonokai_style = 'andromeda'

vim.o.background='dark'
vim.cmd('set termguicolors')
vim.cmd('colorscheme sonokai')
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

vim.keymap.set('n', '<leader>tc', '<cmd>tabnew<cr>', opts)


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

-- Git
vim.keymap.set('n', '[gh', require'vgit'.hunk_up, opts)
vim.keymap.set('n', ']gh', require'vgit'.hunk_down, opts)

-- LSP Telescope
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, opts)
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', '<leader>sw', builtin.lsp_dynamic_workspace_symbols, opts)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, opts)

vim.keymap.set('n', '<space>bt', require'dap'.toggle_breakpoint, opts)
vim.keymap.set('n', '<space>dc', require'dap'.continue, opts)
vim.keymap.set('n', '<space>dt', require'dap'.terminate, opts)
vim.keymap.set('n', '<space>dr', require'dap'.repl.toggle, opts)
vim.keymap.set('n', '<space>dso', require'dap'.step_over, opts)
vim.keymap.set('n', '<space>dsi', require'dap'.step_into, opts)
vim.keymap.set('n', '<leader>df', require'telescope'.extensions.dap.frames, opts)
vim.keymap.set('n', '<leader>dc', require'telescope'.extensions.dap.commands, opts)
vim.keymap.set('n', '<leader>db', require'telescope'.extensions.dap.list_breakpoints, opts)

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

lspconfig.bashls.setup{
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

lspconfig.pyright.setup{
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

-- lspconfig.sumneko_lua.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
--
