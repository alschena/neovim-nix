if vim.g.did_load_java_configuration then
  return
end
vim.g.did_load_java_configuration = true

require('java').setup()
vim.lsp.enable('jdtls')
