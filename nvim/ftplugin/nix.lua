vim.lsp.start {
  name = 'nixd',
  cmd = { 'nixd' },
  root_markers = {
    'flake.nix',
    'default.nix',
    'shell.nix',
    '.git',
  },
}
