if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local api = vim.api
local fn = vim.fn
local keymap = vim.keymap
local diagnostic = vim.diagnostic

-- Remap Esc to switch to normal mode and Ctrl-Esc to pass Esc to terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'switch to normal mode' })
keymap.set('t', '<C-Esc>', '<Esc>', { desc = 'send Esc to terminal' })

-- Shortcut for expanding to current buffer's directory in command mode
keymap.set('c', '%%', function()
  if fn.getcmdtype() == ':' then
    return fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, { expr = true, desc = "expand to current buffer's directory" })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, {desc = 'diagnostics floating window' })
vim.keymap.set('n', 'gd', vim.diagnostic.setloclist, {desc = 'load diagnostics to loclist' })
vim.keymap.set('n', 'gD', vim.diagnostic.setqflist, {desc = 'load diagnostics to quickfixlist' })
vim.keymap.set('n', 'g~d', function() vim.diagnostics.enable(not diagnostic.is_enabled()) end, {desc = 'toggle diagnostics' })
vim.keymap.set('n', 'g~s', function() vim.o.spell = not vim.o.spell end, {desc = 'toggle diagnostics' })

keymap.set('n', '/', '/\\v', { desc = 'very magic search' })
keymap.set('n', '?', '?\\v', { desc = 'very magic backward search' })
keymap.set('v', '/', '/\\v%V', { desc = 'very magic search visual search' })
keymap.set('v', '?', '?\\v%V', { desc = 'very magic backward visual search' })
keymap.set('v', 's', ':s/\\v%V', { desc = 'very magic substitution in visual' })
keymap.set('n', 's', '<Nop>', { desc = 'very magic default substitutions' })
keymap.set('n', 'sb', ':%s/\\v', { desc = 'very magic buffer substitution' })
keymap.set('n', 'sl', ':s/\\v', { desc = 'very magic line substitution' })

keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move [d]own half-page and center' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move [u]p half-page and center' })
keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'move DOWN [f]ull-page and center' })
keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'move UP full-page and center' })
