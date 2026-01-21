require('which-key').setup {
  preset = 'helix',
  plugins = { presets = { motions = false } },
}
vim.keymap.set('n', '<leader>f', '<Nop>', { desc = '+Find' })
vim.keymap.set('n', '<leader>g', '<Nop>', { desc = '+Git' })
vim.keymap.set('n', '<leader>p', '<Nop>', { desc = '+Peek' })
vim.keymap.set('n', '<leader>t', '<Nop>', { desc = '+Toggle/Tab' })
vim.keymap.set('n', '<leader>w', '<Nop>', { desc = '+Workspace/Window' })
vim.keymap.set('n', ',', '<Nop>', { desc = '+Language' })
vim.keymap.set('n', ',~', '<Nop>', { desc = '+toggle' })
vim.keymap.set('n', ',p', '<Nop>', { desc = '+Peek' })
vim.keymap.set('n', ',w', '<Nop>', { desc = '+Workspace' })
