if vim.g.did_load_sonarlint_plugin then
  return
end
vim.g.did_load_sonarlint_plugin = true

require('sonarlint').setup({
  server = {
    cmd = {
      "sonarlint-ls",
      "-stdio"
    },
  },
  filetypes = {
    "c",
    "cpp",
    "python",
    "dockerfile",
    "java",
    "rust",
  },
})
