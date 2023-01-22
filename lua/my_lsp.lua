local M = {}

local merge = require('util').merge
M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, merge(bufopts, { desc = "Go to declaration" }))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, merge(bufopts, { desc = "Go to definition" }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, merge(bufopts, { desc = "Hover" }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, merge(bufopts, { desc = "Go to implementation" }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, merge(bufopts, { desc = "Signature help" }))
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, merge(bufopts, { desc = "Add workspace folder" }))
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, merge(bufopts, { desc = "Remove workspace folder" }))
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, merge(bufopts, { desc = "List workspace folders" }))
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, merge(bufopts, { desc = "Type definition" }))
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, merge(bufopts, { desc = "Rename" }))
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, merge(bufopts, { desc = "Code action" }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, merge(bufopts, { desc = "References" }))
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, merge(bufopts, { desc = "Format" }))

  require'virtualtypes'.on_attach(client, bufnr)
end

return M
