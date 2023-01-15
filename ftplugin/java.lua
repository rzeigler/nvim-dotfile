local config = {
    -- cmd = {'/path/to/jdt-language-server/bin/jdtls'},
    cmd = { 'jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = require('my_lsp').on_attach
}
require('jdtls').start_or_attach(config)
