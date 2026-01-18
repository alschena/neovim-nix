if vim.g.did_load_python_configuration then
  return
end
vim.g.did_load_python_configuration = true

vim.lsp.enable('ty')
vim.lsp.enable('ruff')
