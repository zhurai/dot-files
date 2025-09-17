-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
return {}
