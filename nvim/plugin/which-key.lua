require('which-key').setup {
  preset = 'helix',
  plugins = { presets = { motions = false } },
}
vim.keymap.set('n', '<leader>f', '<Nop>', { desc = '+Find' })
vim.keymap.set('n', ',', '<Nop>', { desc = '+Project' })
vim.keymap.set('n', ',v', '<Nop>', { desc = '+Version control' })
vim.keymap.set('n', ',d', '<Nop>', { desc = '+Diagnostics' })
vim.keymap.set('n', ',~', '<Nop>', { desc = '+Toggle' })
vim.keymap.set('n', ',~v', '<Nop>', { desc = '+Version control' })
vim.keymap.set('n', ',p', '<Nop>', { desc = '+Peek' })
vim.keymap.set('n', ',w', '<Nop>', { desc = '+Workspace' })
vim.keymap.set('n', ',t', '<Nop>', { desc = '+Tests' })
vim.keymap.set('n', ',b', '<Nop>', { desc = '+Debug' })
vim.keymap.set('n', ',bx', '<Nop>', { desc = '+Run' })
