local my_lsp = require('my_lsp')

local jdtls = require('jdtls')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local config = {
    -- cmd = {'/path/to/jdt-language-server/bin/jdtls'},
    cmd = { 'jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = function (client, bufnr)
      local bufopts = { noremap = true, silent=true, buffer=bufnr }
      my_lsp.on_attach(client, bufnr)
      vim.keymap.set('n', '<A-o>', require'jdtls'.organize_imports, bufopts)
      jdtls.setup_dap({})
    end,
    capabilities = capabilities,
    init_options = {
      bundles = {
        vim.fn.glob("$HOME/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
      }
    }
}
jdtls.start_or_attach(config)