local my_lsp = require('my_lsp')

local jdtls = require('jdtls')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local config = {
    -- cmd = {'/path/to/jdt-language-server/bin/jdtls'},
    cmd = { 'jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = function (client, bufnr)
      my_lsp.on_attach(client, bufnr)
      jdtls.setup_dap({})
    end,
    capabilities = capabilities
}
jdtls.start_or_attach(config)
