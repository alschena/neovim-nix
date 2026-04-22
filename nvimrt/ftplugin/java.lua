local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n",
  ",u",
  require('jdtls').organize_imports,
  { silent = true, buffer = bufnr, desc = "organize imports" }
)
vim.keymap.set(
  "n",
  ",c",
  require('jdtls').compile,
  { silent = true, buffer = bufnr, desc = "compile" }
)
vim.keymap.set(
  "n",
  ",xv",
  require('jdtls').extract_variable,
  { silent = true, buffer = bufnr, desc = "extract variable" }
)
vim.keymap.set(
  "n",
  ",xc",
  require('jdtls').extract_constant,
  { silent = true, buffer = bufnr, desc = "extract constant" }
)
vim.keymap.set(
  "n",
  ",xm",
  require('jdtls').extract_method,
  { silent = true, buffer = bufnr, desc = "extract method" }
)
vim.keymap.set(
  "n",
  ",tc",
  require('jdtls').test_class,
  { silent = true, buffer = bufnr, desc = "test class" }
)
vim.keymap.set(
  "n",
  ",tm",
  require('jdtls').test_nearest_method,
  { silent = true, buffer = bufnr, desc = "test nearest method" }
)
