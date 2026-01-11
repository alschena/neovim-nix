require('which-key').setup {
  preset = 'helix'
}
vim.keymap.set('n', '<leader>f', '<Nop>', { desc = '+Find' })
vim.keymap.set('n', '<leader>g', '<Nop>', { desc = '+Git' })
vim.keymap.set('n', '<leader>p', '<Nop>', { desc = '+Peek' })
vim.keymap.set('n', '<leader>t', '<Nop>', { desc = '+Toggle/Tab' })
vim.keymap.set('n', '<leader>w', '<Nop>', { desc = '+Workspace/Window' })
