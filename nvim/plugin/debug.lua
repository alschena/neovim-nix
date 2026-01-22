-- Skip if already loaded
if vim.g.did_load_debuggers then
  return
end
vim.g.did_load_debuggers = true

vim.keymap.set('n', ',b', '<Nop>', { desc = '+Debug' })
vim.keymap.set('n', ',bc', function() require('dap').continue() end, { desc = 'Continue' })
vim.keymap.set('n', ',br', function() require('dap').step_over() end, { desc = 'Step over' })
vim.keymap.set('n', ',bi', function() require('dap').step_into() end, { desc = 'Step into' })
vim.keymap.set('n', ',bo', function() require('dap').step_out() end, { desc = 'Step out' })
vim.keymap.set('n', ',bt', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', ',bb', function() require('dap').set_breakpoint() end, { desc = 'Set breakpoint' })
vim.keymap.set('n', ',bB', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Set logging breakpoint' })
vim.keymap.set('n', ',bs', function() require('dap').repl.open() end, { desc = 'Open repl' })
vim.keymap.set('n', ',bl', function() require('dap').run_last() end, { desc = 'Run last' })
vim.keymap.set({ 'n', 'v' }, ',bk', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Hover' })
vim.keymap.set({ 'n', 'v' }, ',bp', function()
  require('dap.ui.widgets').preview()
end, { desc = 'Preview' })
vim.keymap.set('n', ',bf', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = 'Centered floating frame' })
vim.keymap.set('n', ',bF', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = 'Centered floating scope' })
