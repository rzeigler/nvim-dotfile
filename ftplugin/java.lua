local util = require'lspconfig.util'

local jdtls = require('jdtls')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local my_lsp = require('my_lsp')

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
  JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or util.path.join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
  return util.path.join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
  return util.path.join(get_jdtls_cache_dir(), 'config')
end

local function get_jdtls_workspace_dir()
  return util.path.join(get_jdtls_cache_dir(), 'workspace')
end

local root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1])
local workspace_root = root_dir:gsub('\\/', '_')

local config = {
    -- cmd = {'/path/to/jdt-language-server/bin/jdtls'},
    root_dir = root_dir,
    cmd = { 'jdtls', '--data', get_jdtls_workspace_dir() .. workspace_root },
    on_attach = function (client, bufnr)
      local bufopts = { noremap = true, silent=true, buffer=bufnr }
      my_lsp.on_attach(client, bufnr)
      vim.keymap.set('n', '<A-o>', require'jdtls'.organize_imports, bufopts)
      jdtls.setup_dap({})
      require('jdtls.setup').add_commands()
    end,
    capabilities = capabilities,
    init_options = {
      bundles = {
        vim.fn.glob("$HOME/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
      }
    }
}
jdtls.start_or_attach(config)
