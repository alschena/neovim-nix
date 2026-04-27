return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    '.git',
    'uv.lock',
    'pyproject.toml',
  },
}
