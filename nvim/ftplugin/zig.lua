if vim.g.did_load_zig_configuration then
  return
end
vim.g.did_load_zig_configuration = true

vim.lsp.config['zls'] = {
  cmd = { 'zls' },
  filetypes = { 'zig' },
  root_markers = { 'build.zig' },
  -- There are two ways to set config options:
  --   - edit your `zls.json` that applies to any editor that uses ZLS
  --   - set in-editor config options with the `settings` field below.
  --
  -- Further information on how to configure ZLS:
  -- https://zigtools.org/zls/configure/
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics
      --
      -- Further information about build-on save:
      -- https://zigtools.org/zls/guides/build-on-save/
      -- enable_build_on_save = true,
    }
  },
}
vim.lsp.enable('zls')


-- On save: format, fix all, organize imports
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*.zig", "*.zon" },
  callback = function(_)
    vim.lsp.buf.format()
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll", "source.organizeImports" } },
      apply = true,
    })
  end
})

