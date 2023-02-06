require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'sainnhe/edge'

  use 'nvim-tree/nvim-web-devicons'

  use 'godlygeek/tabular'

  use {
    'tversteeg/registers.nvim',
    config = function()
      require('registers').setup({})
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use 'tpope/vim-eunuch'
  use 'tpope/vim-vinegar'

  use 'ixru/nvim-markdown'

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[h', function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          -- map('n', '<leader>hd', gs.diffthis)
          -- map('n', '<leader>hD', function() gs.diffthis('~') end)
          -- map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
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
    'terrortylor/nvim-comment',
    config = function()
      require'nvim_comment'.setup {}
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      local navic = require'nvim-navic'
      require 'lualine'.setup {
        options = {
          theme = 'edge'
        },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = true,
              path = 1,
            }
          }
        },
        winbar = {
          lualine_c = {
            'filename',
            {
              navic.get_location,
              cond = navic.is_available
            }
          }
        }
      }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    require = { 'nvim-treesitter/nvim-treesitter-textobjects', 'RRethy/nvim-treesitter-textsubjects' },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
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
              ["at"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["it"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["ac"] = "@comment.outer",
              ["ic"] = "@comment.inner"
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

  use {
    'nvim-treesitter/nvim-treesitter-context',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require'treesitter-context'.setup {
        enable = false
      }
    end
  }

  use 'RRethy/nvim-treesitter-textsubjects'

  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter'
        },
        delay = 400,
        filetypes_denylist = {
          'gitcommit'
        }
      })
    end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = "0.1.0",
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require 'telescope'.setup {}
    end
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = function()
      require'telescope'.load_extension('file_browser')
    end
  }
  use {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require 'telescope'.load_extension('ui-select')
    end
  }
  use {
    'nvim-telescope/telescope-dap.nvim',
    config = function()
      require 'telescope'.load_extension('dap')
    end
  }
  use {
    'nvim-telescope/telescope-symbols.nvim',
  }
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    config = function()
      require 'telescope'.load_extension('fzy_native')
    end
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    requires = { "kkharji/sqlite.lua" }
  }
  use {
    'LinArcX/telescope-env.nvim',
    config = function()
      require 'telescope'.load_extension('env')
    end
  }

  use 'neovim/nvim-lspconfig'

  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require 'nvim-navic'.setup({})
    end
  }

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
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
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

      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('config_done', cmp_autopairs.on_confirm_done())
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

  use 'jubnzv/virtual-types.nvim'

  use 'mfussenegger/nvim-dap'
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end
  }
  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end
  }

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

vim.o.background = 'dark'
vim.cmd('set termguicolors')
vim.cmd('colorscheme edge')
vim.cmd('set number')
vim.cmd('set expandtab shiftwidth=2 tabstop=2')
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd('syntax off')

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

-- Workaround for https://github.com/nvim-treesitter/nvim-treesitter/issues/1337#issuecomment-1397639999 
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>cf', '<cmd>FidgetClose<cr>', opts)
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
vim.keymap.set('n', '<leader>fs', builtin.symbols, opts)
vim.keymap.set('n', '<leader>bf', require'telescope'.extensions.file_browser.file_browser, opts)


-- Diagnostics
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


vim.keymap.set('n', '<space>bt', require 'dap'.toggle_breakpoint, opts)
vim.keymap.set('n', '<space>bc', require 'dap'.clear_breakpoints, opts)
vim.keymap.set('n', '<space>dc', require 'dap'.continue, opts)
vim.keymap.set('n', '<space>dt', require 'dap'.terminate, opts)
vim.keymap.set('n', '<space>dp', require 'dap'.run_last, opts)
vim.keymap.set('n', '<space>dr', require 'dap'.repl.toggle, opts)
vim.keymap.set('n', '<space>sf', require 'dap'.step_over, opts)
vim.keymap.set('n', '<space>si', require 'dap'.step_into, opts)
vim.keymap.set('n', '<space>so', require 'dap'.step_out, opts)

vim.keymap.set('n', '<space>fj', require 'dap'.focus_frame, opts)
vim.keymap.set('n', '<space>fu', require 'dap'.up, opts)
vim.keymap.set('n', '<space>fd', require 'dap'.down, opts)

-- LSP Telescope
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, opts)
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', '<leader>sw', builtin.lsp_dynamic_workspace_symbols, opts)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, opts)

vim.keymap.set('n', '<leader>df', require 'telescope'.extensions.dap.frames, opts)
vim.keymap.set('n', '<leader>dc', require 'telescope'.extensions.dap.commands, opts)
vim.keymap.set('n', '<leader>db', require 'telescope'.extensions.dap.list_breakpoints, opts)

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

lspconfig.bashls.setup {
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

lspconfig.pyright.setup {
  on_attach = require('my_lsp').on_attach,
  capabilities = capabilities
}

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
