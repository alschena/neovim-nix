if vim.g.did_load_java_configuration then
  return
end
vim.g.did_load_java_configuration = true

vim.lsp.enable('jdtls')
