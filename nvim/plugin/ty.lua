if vim.g.did_load_python_type_checker then
  return
end
vim.g.did_load_python_type_checker = true

vim.lsp.enable('ty')
